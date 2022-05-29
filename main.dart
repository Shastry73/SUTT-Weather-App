import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/data_servers.dart';
import 'package:weather_application/post.dart';

void main() {
  runApp(MaterialApp(
    home: weather(),
  ));
}

class weather extends StatefulWidget {
  const weather({Key? key}) : super(key: key);

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  final _citytextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;
  var locationInfo = '';

  // WeatherResponse? get esponse => _response;

  // WeatherResponse? placemarks;

  void getCurrentLocation() async {
    var location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));
    var lastLocation = await Geolocator.getLastKnownPosition();

    print(lastLocation);

    setState(() {
      locationInfo = '${location.latitude}, ${location.longitude}';
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      String myCity = placemarks[0].locality!;

      final response = await _dataService.getWeather(myCity);

      setState(() => _response = response);
      print(placemarks[0].locality);
    } catch (err) {}

    //_response?.cityName =
    //_search();
    WeatherICON();
  }

  WeatherStatus weathstat = WeatherStatus();
  Weather_Status weather = Weather_Status();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          weather.getWeatherIcon('${_response?.weatherInfo.description}'),
      // getCurrentLocation();
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Weather App', textAlign: TextAlign.center),
      ),
      resizeToAvoidBottomInset: false, // set it to false
      //backgroundColor: Colors.indigo,
      body: Container(
        child: SafeArea(
          child: Container(
            //Add box decoration
            // decoration: BoxDecoration(
            //   gradient: RadialGradient(
            //     center: Alignment(0.0, 0.0), // near the top right
            //     radius: 0.6,
            //     colors: <Color>[
            //       Colors.blue,
            //       Colors.indigo,
            //     ],
            //     stops: <double>[0.4, 1.0],
            //   ),
            // ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if (_response == null)

                            Column(
                              children: [
                                Text(
                                  '  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${_response?.weatherInfo.description}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )
                          ],
                        )),
                    // SizedBox(width: 140),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text(''),
                      icon: Icon(
                        Icons.sort,
                        color: Colors.white,
                        size: 35,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: weather.getWeatherIcon(
                              '${_response?.weatherInfo.description}')),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 235,
                    // )
                  ],
                ),
                Container(
                  child: TextField(
                    controller: _citytextController,
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  weathstat.getWeatherIcon(
                    '${_response?.weatherInfo.description}',
                  ),
                  style: TextStyle(
                    fontSize: 150,
                  ),
                ),
                ElevatedButton(
                    onPressed: _search,
                    child: Text(
                      'Search',
                    )),
                Container(
                  child: Row(
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Text('${_response?.cityName}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        ' ${_response?.tempInfo.temperature}°',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 100,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Text(
                  'feels like ${_response?.feels_like.feels_like}°',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: getCurrentLocation,
                  child: Text(
                    'Weather at your place',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_citytextController.text);

    setState(() => _response = response);
  }

  // Future<void> WeatherICON() async {
  //   final esponse = await '${_response?.weatherInfo.description}';
  // }
  void WeatherICON() async {
    // setState(() => _response = esponse);
  }
}

class WeatherStatus {
  String getWeatherIcon(String condition) {
    //print(condition + "gdrtdycfjycfgjycjffcxhxht");
    if (condition == 'thunderstorm') {
      return '🌩';
    } else if (condition == 'rain') {
      return '🌧';
    } else if (condition == 'shower rain') {
      return '☔️';
    } else if (condition == 'snow') {
      return '☃️';
    } else if (condition == 'mist') {
      return '🌫';
    } else if (condition == 'clear sky') {
      return '☀️';
    } else if (condition == 'clouds') {
      return '☁️';
    } else {
      return ''; //'🤷‍';
    }
  }
}

class Weather_Status {
  Color getWeatherIcon(String condition) {
    //print(condition + "gdrtdycfjycfgjycjffcxhxht");
    if (condition == 'thunderstorm') {
      return Colors.deepPurple;
    } else if (condition == 'rain') {
      return Colors.blue;
    } else if (condition == 'shower rain') {
      return Colors.lightBlueAccent;
    } else if (condition == 'snow') {
      return Colors.white30;
    } else if (condition == 'mist') {
      return Colors.grey;
    } else if (condition == 'clear sky') {
      return Colors.yellow.shade400;
    } else if (condition == 'clouds') {
      return Colors.black12;
    } else {
      return Colors.blueGrey.shade900; //'🤷‍';
    }
  }
}
