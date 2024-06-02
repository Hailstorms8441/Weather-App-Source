import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MainForcast {
  final int temp;
  final int feelslike;

  const MainForcast({
    required this.temp,
    required this.feelslike
  });
  factory MainForcast.fromJson(Map <String, dynamic> json){
    return MainForcast(temp: json['temp'].toInt(), feelslike: json['feels_like'].toInt());
  }
}

class WindForcast {
  final int speed;

  const WindForcast({
    required this.speed,
  });
  factory WindForcast.fromJson(Map <String, dynamic> json){
    return WindForcast(speed: json['speed'].toInt());
  }
}

class ForcastElement {
  final MainForcast main;
  final WindForcast wind;
  final String time;
  final double pop;

  const ForcastElement({
    required this.pop,
    required this.main,
    required this.time,
    required this.wind
  });

  factory ForcastElement.fromJson(Map <String, dynamic> json) {
    return ForcastElement(main: MainForcast.fromJson(json['main']), time: unixtotime(json['dt']), wind: WindForcast.fromJson(json['wind']), pop: json['pop'] * 100);
  }


}

class ForcastData {
  
  final List<ForcastElement> list;

  const ForcastData({
    required this.list
  });

  factory ForcastData.fromJson(Map<String, dynamic> json) {
    List<ForcastElement> forcastlist = [];
    for (var i = 0; i < 40; i++) {
      forcastlist.add(ForcastElement.fromJson(json['list'][i]));
    }
    return ForcastData(
      list: forcastlist
    );
  }
}


class ForcastService {
  Future<ForcastData> getData(String lon, String lat, String apikey) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?units=imperial&lat=$lat&lon=$lon&appid=$apikey')); 
    if (response.statusCode == 200) {
      return ForcastData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("You Haven't entered a valid api key, to do so open the drawer and enter it there");
    }
  }


}

String unixtotime(int timestamp) {
  String date1 = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toString();
  //final dateFormat = DateFormat('h:mm a');
  final stringFormat = DateFormat.MMMd().add_jm().format(DateTime.parse(date1));
  return stringFormat;
}