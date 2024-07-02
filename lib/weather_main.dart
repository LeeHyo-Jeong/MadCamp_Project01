import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Weather {
  final String description;
  final double temperature;
  final int humidity;
  final int sunrise;
  final int sunset;
  final iconUrl;
  final cityName;
  final int timeZone;

  DateTime currentTime = DateTime.now();

  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.iconUrl,
    required this.cityName,
    required this.timeZone,
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
      timeZone: json['timezone'],
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with AutomaticKeepAliveClientMixin {
  late Future<Weather> _weatherFuture;

  @override
  bool get wantKeepAlive => true;

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
          '$apiBaseUrl?lat=${position.latitude}&lon=${position
              .longitude}&appid=${apiKey}');
      response = await http.get(url);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        weather = Weather.fromJson(data);

        var nowUtc = DateTime.now().toUtc();
        weather.currentTime = nowUtc.add(Duration(seconds: weather.timeZone));

        return weather;
      } else {
        throw Exception('Failed to load weather: ${response.body}');
      }
    } catch (e) {
      print("Error occured: $e");
      rethrow;
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

  String formatTimeStamp(int timestamp, int timezone) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        (timestamp + timezone) * 1000,
        isUtc: true);
    return DateFormat("h:mm a").format(date);
  }

  String getCurrentTime(DateTime now) {
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    final Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: View
          .of(context)
          .platformDispatcher
          .platformBrightness == Brightness.light ? Color(0xff98e0ff) : Colors
          .black,
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
                                SizedBox(height: size.height * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      SizedBox(width: 20),
                                      Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            text: TextSpan(
                                                text: '${weather.cityName}',
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                )),
                                          )),
                                      IconButton(
                                        icon: Icon(Icons.location_searching),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            _weatherFuture = getWeather();
                                          });
                                        },
                                      ),
                                    ]),
                                    Row(children: [
                                      SizedBox(width: 20),
                                      TimerBuilder.periodic(
                                          Duration(minutes: 1),
                                          builder: (context) {
                                            return Text(
                                                '${getCurrentTime(
                                                    weather.currentTime)}',
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
                                SizedBox(height: size.height * 0.115),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${(weather.temperature - 273.15)
                                            .toStringAsFixed(0)}°',
                                        style: TextStyle(
                                          fontSize: 70,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    AspectRatio(
                                      aspectRatio: 2.5, // 원하는 비율
                                      child: CachedNetworkImage(
                                        imageUrl: weather.iconUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    //Image.network(weather.iconUrl),
                                    Text('${weather.description}',
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                        )),
                                    SizedBox(height: 10),
                                    Text('humidity: ${weather.humidity}%',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    Text(
                                        'sunrise: ${formatTimeStamp(
                                            weather.sunrise,
                                            weather.timeZone)}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    Text(
                                        'sunset: ${formatTimeStamp(
                                            weather.sunset, weather.timeZone)}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white))
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
