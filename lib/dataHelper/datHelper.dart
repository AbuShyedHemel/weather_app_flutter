import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AppData extends ChangeNotifier {
  String data = '';
  String weather = 'clear';
  int ?temparature = 0;
  String location = 'Dhaka';
  int woeid = 2487956;
  String searchUrl = 'https://www.metaweather.com/api/location/search/?query=';
  String locationApiUrl = 'https://www.metaweather.com/api/location/';
  String abbrewation = 'c';
  String errorMessage = '';
  // ignore: deprecated_member_use
  var minTemperatureForcast = List.filled(7, null, growable: false);
  var mixTemperatureForcast = new List.filled(7, null, growable: false);
  var abbreviationForcast = new List.filled(7, null, growable: false);

  Future fetchSearch(String input) async {
    try {
      var searchResult = await http.get(Uri.parse(searchUrl + input));
      var result = json.decode(searchResult.body)[0];

      location = result['title'];
      woeid = result["woeid"];
      errorMessage = '';
    } catch (error) {
      errorMessage = "Sorry We Can't find your location in the DataBase";
      //notifyListeners();
    }
    notifyListeners();
  }

  Future fetchLocation() async {
    var locationResult =
        await http.get(Uri.parse(locationApiUrl + woeid.toString()));
    var result = json.decode(locationResult.body);
    print(result);
    // ignore: non_constant_identifier_names
    var consoldated_weather = result["consolidated_weather"];
    var data = consoldated_weather[0];

    temparature = data["the_temp"].round();
    weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
    abbrewation = data["weather_state_abbr"];

    notifyListeners();
  }

  Future fetchLocationDay() async {
    var todey = new DateTime.now();
    for (var i = 0; i < 7; i++) {
      var locationDayResult = await http.get(Uri.parse(locationApiUrl + woeid.toString() + '/' +new DateFormat('y/M/d').format(todey.add(new Duration(days: i + 1))).toString()));
      print(locationDayResult);
      var result = json.decode(locationDayResult.body);
      var data = result[0];

      print(data['min_temp'].round());
      minTemperatureForcast[i] = data["min_temp"].round();
      mixTemperatureForcast[i] = data["max_temp"].round();
      abbreviationForcast[i] = data["weather_state_abbr"];

      notifyListeners();
    }
  }

  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    await fetchLocation();
    await fetchLocationDay();
    notifyListeners();
  }
}
