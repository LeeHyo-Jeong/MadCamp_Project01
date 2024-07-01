import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

class Weather {
  final String description;
  final double temperature;
  final iconUrl;

  Weather({required this.description, required this.temperature, required this.iconUrl});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      iconUrl: 'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',

    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Future<Weather> getWeather() async {
    final String? apiKey = dotenv.env['openWeatherApiKey'];
    final String? apiBaseUrl = dotenv.env['openWeatherApiBaseUrl'];

    http.Response response;
    var data;
    Weather weather;

    try {
      Uri url = Uri.parse('$apiBaseUrl?appid=$apiKey');
      response = await http.get(url);

      if (response.statusCode == 200) {
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

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Scaffold(
        backgroundColor: Color(0xff98e0ff),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
                child: FutureBuilder<Weather>(
                    future: getWeather(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      else if (snapshot.hasData) {
                        Weather weather = snapshot.data!;
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${(weather.temperature - 273.15)
                                  .toStringAsFixed(0)}°C',
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Image.network(weather.iconUrl),
                              Text('${weather.description}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  )
                              ),
                            ]
                        );
                      }
                      else {
                        return Text('No data available');
                      }
                    }
                )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                ),
                Text('Daejeon',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                ),
                Row(
                    children: [
                      TimerBuilder.periodic(Duration(minutes: 1),
                          builder: (context) {
                            print('${getSystemTime()}');
                            return Text(
                                '${getSystemTime()}',
                                style: TextStyle(fontSize: 16.0,
                                    color: Colors.white)
                            );
                          }
                      ),
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
                    ]
                )
              ],
            ),
          ],
        )
    );
  }
}
