import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentData {
  final double temp;
  final double feelslike;

  const CurrentData({
    required this.temp,
    required this.feelslike
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(temp: json['temp'], feelslike: json['feels_like']);
  }
}

class WindData {
  final double speed;

  const WindData({
    required this.speed
  });

  factory WindData.fromJson(Map<String, dynamic> json) {
    return WindData(speed: json['speed']);
  }
}

class CloudData {
  final int cover;

  const CloudData({
    required this.cover
  });

  factory CloudData.fromJson(Map<String, dynamic> json) {
    return CloudData(cover: json['all']);
  }
}

class WeatherData {
  final CurrentData current;
  final WindData winddata;
  final CloudData clouddata;

  const WeatherData({
    required this.current,
    required this.winddata,
    required this.clouddata
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      current: CurrentData.fromJson(json['main']),
      winddata: WindData.fromJson(json['wind']),
      clouddata: CloudData.fromJson(json['clouds'])
    );
  }
}

class WeatherService {
  Future<WeatherData> getData(String lon, String lat, String apikey) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=imperial&appid=$apikey'));  
    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("You Haven't entered a valid api key, to do so open the drawer and enter it there");
    }
  }


}