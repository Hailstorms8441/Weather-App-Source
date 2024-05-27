import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationData {
  final double lat;
  final double lon;

  const LocationData({
    required this.lat,
    required this.lon
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      lat: json['lat'],
      lon: json['lon']
    );
  }
}

class LocationService {
  Future<LocationData> getData(String city, String apikey) async {
    final response = await http
      .get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apikey'));
    if (response.statusCode == 200) {
      return LocationData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("The first exeption was tripped");
    }
  }
}

