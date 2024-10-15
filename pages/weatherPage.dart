import 'package:flutter/material.dart';
import '../services/weatherService.dart';
import '../models/weather.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;

  WeatherPage({required this.cityName});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Weather> _weather;

  @override
  void initState() {
    super.initState();
    _weather = _fetchWeather();
  }

  Future<Weather> _fetchWeather() async {
    final weatherService = WeatherService();
    final weatherData = await weatherService.fetchWeather(widget.cityName);
    return Weather.fromJson(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${widget.cityName}'),
      ),
      body: FutureBuilder<Weather>(
        future: _weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching weather'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_getBackgroundImage(weather.icon)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weather.description,
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                      scale: 0.5,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  String _getBackgroundImage(String icon) {
    switch (icon) {
      case '01d':
        return 'assets/sun.png';
      case '01n':
        return 'assets/night.jpg';
      case '09d':
      case '10d':
        return 'assets/rain.png';
      default:
        return 'assets/cloudy.png';
    }
  }
}
