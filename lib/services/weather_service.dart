import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city, String apiKey) async {
    if (apiKey.isEmpty) throw Exception('Missing OpenWeather API key.');
    final uri = Uri.parse('$_baseUrl?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Weather request failed: ${response.statusCode}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
