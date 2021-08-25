import 'dart:convert';
import 'package:http/http.dart';

class OpenWeatherMapService {
  OpenWeatherMapService({this.url});

  final API_KEY = '900f8c0d7b9b8fc2190c894ee0396aaf';
  final BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String url;

  Future<dynamic> fetch(double lat, double lon) async {
    Response response = await get(
      Uri.parse('$BASE_URL?lat=${lat}&lon=${lon}&appid=$API_KEY&units=metric'),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
  }

  Future<dynamic> fetchWeatherByCity(String city) async {
    Response response = await get(Uri.parse('$BASE_URL?q=${city}&appid=$API_KEY&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}
