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
                  const Text(style: TextStyle(fontSize: 50, decoration: TextDecoration.underline), "Current Weather:"),
                  const Text(style: TextStyle(fontSize: 5), ""),
                  Text(style: const TextStyle(fontSize: 39), "${snapshot.data!.current.temp.toInt()} Degrees Farenheight"), 
                  Text(style: const TextStyle(fontSize: 39), "Feels like: ${snapshot.data!.current.feelslike.toInt()}"),
                  Text(style: const TextStyle(fontSize: 39), "Wind Speed: ${snapshot.data!.winddata.speed.toInt()} MPH"),
                  Text(style: const TextStyle(fontSize: 39), "Cloud Cover: ${snapshot.data!.clouddata.cover}%")
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