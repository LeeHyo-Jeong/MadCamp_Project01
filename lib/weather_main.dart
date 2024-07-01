import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

class Weather {
  final String description;
  final double temperature;
  final int humidity;
  final int sunrise;
  final int sunset;
  final iconUrl;

  Weather(
      {required this.description,
      required this.temperature,
      required this.humidity,
      required this.sunrise,
      required this.sunset,
      required this.iconUrl});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      iconUrl:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  Future<Weather> getWeather() async {
    final String? apiKey = await dotenv.env['openWeatherApiKey'];
    final String? apiBaseUrl = await dotenv.env['openWeatherApiBaseUrl'];

    http.Response response;
    var data;
    Weather weather;

    try {
      Uri url = Uri.parse('$apiBaseUrl?appid=$apiKey');
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

  void _initdata() async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: "assets/config/.env");
  }

  @override
  void initState() {
    _initdata();
    super.initState();
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("h:mm a").format(now);
  }

  String formatTimeStamp(int timestamp){
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
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Daejeon',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Row(children: [
                      SizedBox(width: 10),
                      TimerBuilder.periodic(Duration(minutes: 1),
                          builder: (context) {
                        return Text('${getSystemTime()}',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white));
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
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                  ],
                ),
                FutureBuilder<Weather>(
                    future: getWeather(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting || (snapshot.hasError && snapshot.error.toString() == "Invalid argument(s): No host specified in URI null?appid=null")) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) { // 왜 에러가 발생하지..?
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        Weather weather = snapshot.data!;
                        return Column(
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
                              fontSize: 14,
                              color: Colors.white
                            )),
                            Text('sunrise: ${formatTimeStamp(weather.sunrise)}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                )),
                            Text('sunset: ${formatTimeStamp(weather.sunset)}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                ))
                          ],
                        );
                      } else {
                        return Text('No data available');
                      }
                    }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
