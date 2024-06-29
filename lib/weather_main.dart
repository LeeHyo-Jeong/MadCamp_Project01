import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Weather {
  final String description;
  final double temperature;

  Weather({required this.description, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Weather>(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Weather weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Description: ${weather.description}'),
                  Text('Temperature: ${weather.temperature}°C'),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
