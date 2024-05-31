import 'package:http/http.dart' as http;
import 'dart:convert';

class MainForcast {
  final double temp;

  const MainForcast({
    required this.temp
  });
  factory MainForcast.fromJson(Map <String, dynamic> json){
    return MainForcast(temp: json['temp']);
  }
}

class ForcastElement {
  final MainForcast main;

  const ForcastElement({
    required this.main
  });

  factory ForcastElement.fromJson(Map <String, dynamic> json) {
    return ForcastElement(main: json['main']);
  }


}

class ForcastData {
  
  final List<ForcastElement> list;

  const ForcastData({
    required this.list
  });

  factory ForcastData.fromJson(Map<String, dynamic> json) {
    return ForcastData(
      list: 
      [
        ForcastElement.fromJson(json['list'][0]),
        ForcastElement.fromJson(json['list'][1]),
        ForcastElement.fromJson(json['list'][2]),
        ForcastElement.fromJson(json['list'][3]),
        ForcastElement.fromJson(json['list'][4]),
      ]
    );
  }
}


class ForcastService {
  Future<ForcastData> getData(String lon, String lat, String apikey) async {
    final response = await http
        .get(Uri.parse('api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apikey'));  
    if (response.statusCode == 200) {
      return ForcastData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("You Haven't entered a valid api key, to do so open the drawer and enter it there");
    }
  }


}