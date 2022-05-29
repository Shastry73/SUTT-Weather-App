import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_application/post.dart';

class DataService {
  Future<WeatherResponse?> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '6f420783df36bc5d60d62728d133ed73',
      'units': 'metric'
    };

    // var response = await http.get(Uri.parse(
    //     'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=86fb5ee6347a1dd0d1054468963d7a8c'));
    //
    // print('hello data fetched');
    // print(response.statusCode);
    //
    // if (response.statusCode == 200) {
    //   print('hi hello i here');
    //   var json = jsonDecode(response.body);
    //
    //   print(json);
    //   return WeatherResponse.fromJson(json);
    // }
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    //print('hi hello i here');
    print(WeatherResponse.fromJson(json));
    return WeatherResponse.fromJson(json);
  }
}
