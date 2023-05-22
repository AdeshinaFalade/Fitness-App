import 'package:flutter_practice/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/constants.dart';

class HttpHelper{
  final String apiKey = 'ced5e6c2b4bb9435f9fb35c240eaeecb';
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  Future<Weather> getWeather(String location) async{
    Map<String, dynamic> parameters = {'q': location,'appId': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = jsonDecode(result.body);
    //print(result.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }

}