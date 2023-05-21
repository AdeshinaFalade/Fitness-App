import 'package:flutter/material.dart';
import 'package:flutter_practice/data/http_helper.dart';
import 'package:flutter_practice/data/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController txtPlace = TextEditingController();
  Weather result = Weather('','',0,0,0,0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
              child: TextField(
                controller: txtPlace,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter a city',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: getData,
                  )
                ),
              ),
            ),
            weatherRow('Place: ', result.name),
            weatherRow('Description: ', result.description),
            weatherRow('Temperature: ', result.temperature.toStringAsFixed(2)),
            weatherRow('Perceived: ', result.perceived.toStringAsFixed(2)),
            weatherRow('Pressure: ', result.pressure.toString()),
            weatherRow('Humidity: ', result.humidity.toString()),
          ],
        ),
      )
    );
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtPlace.text);
    setState(() {

    });
  }
  Widget weatherRow(String label, String value){
    Widget row = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
              child: Text(label,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).hintColor
              ))
          ),
          Expanded(
              flex: 4,
              child: Text(value,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor
                  )))
        ]));
        return row;
  }

}

