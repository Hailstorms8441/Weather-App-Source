import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "weather app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 87, 166, 161),
          primary: const Color.fromARGB(255, 87, 166, 161)
        )
      ),
      home: const HomePage(),
    );
  }
}