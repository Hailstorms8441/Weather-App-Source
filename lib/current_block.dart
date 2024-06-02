import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';

class CurrentBlock extends StatelessWidget {
  final Future<WeatherData> weatherData;

  const CurrentBlock({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 87, 123, 141),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: FutureBuilder<WeatherData>(future: weatherData, builder: (context, snapshot) {
          if (snapshot.hasData) {
              return Column(
                children: [
                  const Text(style: TextStyle(fontSize: 60, decoration: TextDecoration.underline), "Current Weather:"),
                  const Text(style: TextStyle(fontSize: 20), ""),
                  Text(style: const TextStyle(fontSize: 45), "Current Temp: ${snapshot.data!.current.temp.toInt()}°F"), 
                  Text(style: const TextStyle(fontSize: 45), "Feels Like: ${snapshot.data!.current.feelslike.toInt()}°F"),
                  Text(style: const TextStyle(fontSize: 45), "Current Conditions: ${snapshot.data!.weatherdesc.desc}"),
                  Text(style: const TextStyle(fontSize: 45), "Wind Speed: ${snapshot.data!.winddata.speed.toInt()} MPH"),
                  Text(style: const TextStyle(fontSize: 45), "Humidity: ${snapshot.data!.current.humidity.toInt()}%"),
                  Text(style: const TextStyle(fontSize: 45), "Pressure: ${snapshot.data!.current.pressure.toInt()} hPa"),
                  Text(style: const TextStyle(fontSize: 45), "Visibility: ${snapshot.data!.visibility.toInt()} km"),
                ]);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
          return const CircularProgressIndicator();
        },)
        ),
    );
  }
}