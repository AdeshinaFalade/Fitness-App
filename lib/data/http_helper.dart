import 'package:flutter_practice/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../shared/constants.dart';

class HttpHelper{

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