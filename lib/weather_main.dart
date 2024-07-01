import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class Weather {
  final String description;
  final double temperature;
  final int humidity;
  final int sunrise;
  final int sunset;
  final iconUrl;
  final cityName;

  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.iconUrl,
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      iconUrl:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
      cityName: json['name'],
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  late Future<Weather> _weatherFuture;

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // 설정 열어서 권한 받을 수 있도록 수정하기
      return Future.error('Location services are disalbed.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissoins are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Weather> getWeather() async {
    final String? apiKey = await dotenv.env['openWeatherApiKey'];
    final String? apiBaseUrl = await dotenv.env['openWeatherApiBaseUrl'];

    http.Response response;
    var data;
    Weather weather;

    try {
      final position = await getPosition();

      Uri url = Uri.parse(
          '$apiBaseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=${apiKey}');
      response = await http.get(url);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        data = json.decode(response.body);
        weather = Weather.fromJson(data);
        return weather;
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void _initdata() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: "assets/config/.env");
    _weatherFuture = getWeather();
  }

  @override
  void initState() {
    _initdata();
    _weatherFuture = getWeather();
    super.initState();
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("h:mm a").format(now);
  }

  String formatTimeStamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat("h:mm a").format(date);
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff98e0ff),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(children: [
          Container(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    FutureBuilder<Weather>(
                        future: _weatherFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              (snapshot.hasError &&
                                  snapshot.error.toString() ==
                                      "Invalid argument(s): No host specified in URI null?appid=null")) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            Weather weather = snapshot.data!;
                            return Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      SizedBox(width: 10),
                                      Text('${weather.cityName}',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                        icon: Icon(Icons.location_searching),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState((){
                                            _weatherFuture = getWeather();
                                          });
                                        },
                                      ),
                                    ]),
                                    Row(children: [
                                      SizedBox(width: 10),
                                      TimerBuilder.periodic(
                                          Duration(minutes: 1),
                                          builder: (context) {
                                        return Text('${getSystemTime()}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white));
                                      }),
                                      Text(
                                        DateFormat(' - EEEE, ').format(date),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('d MMM, yyy').format(date),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${(weather.temperature - 273.15).toStringAsFixed(0)}°',
                                        style: TextStyle(
                                          fontSize: 70,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Image.network(weather.iconUrl),
                                    Text('${weather.description}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        )),
                                    SizedBox(height: 10),
                                    Text('humidity: ${weather.humidity}%',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    Text(
                                        'sunrise: ${formatTimeStamp(weather.sunrise)}',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    Text(
                                        'sunset: ${formatTimeStamp(weather.sunset)}',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white))
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Text('No data available');
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
