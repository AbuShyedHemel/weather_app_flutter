import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dataHelper/datHelper.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppData>(context, listen: false).fetchLocation();
    Provider.of<AppData>(context, listen: false).fetchLocationDay();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var weight = MediaQuery.of(context).size.width;
    AppData _data = Provider.of<AppData>(context);

    return _data.temparature == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage( _data.weather == null ? "image/clear.png": 'image/${_data.weather}.png',),fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      onSubmitted: (String input) {
                        _data.onTextFieldSubmitted(input);
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        hintText: "Search a Location Here",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    height: height / 2.75,
                    width: weight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.network(
                            _data.abbrewation != null
                                ? 'https://www.metaweather.com/static/img/weather/png/' +
                                    _data.abbrewation +
                                    '.png'
                                : 'image/180.png',
                            width: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            _data.location.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            _data.temparature != null
                                ? _data.temparature.toString() + "\u00B0"
                                : "Loading..",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 50.0,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            _data.weather != null
                                ? _data.weather.toString().toUpperCase()
                                : "Loading..",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              //fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Text(
                          _data.errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              forcastElement(
                                  1,
                                  _data.abbreviationForcast[0],
                                  _data.minTemperatureForcast[0],
                                  _data.mixTemperatureForcast[0]),
                              forcastElement(
                                  2,
                                  _data.abbreviationForcast[1],
                                  _data.minTemperatureForcast[1],
                                  _data.mixTemperatureForcast[1]),
                              forcastElement(
                                  3,
                                  _data.abbreviationForcast[2],
                                  _data.minTemperatureForcast[2],
                                  _data.mixTemperatureForcast[2]),
                              forcastElement(
                                  4,
                                  _data.abbreviationForcast[3],
                                  _data.minTemperatureForcast[3],
                                  _data.mixTemperatureForcast[3]),
                              forcastElement(
                                  5,
                                  _data.abbreviationForcast[4],
                                  _data.minTemperatureForcast[4],
                                  _data.mixTemperatureForcast[4]),
                              forcastElement(
                                  6,
                                  _data.abbreviationForcast[5],
                                  _data.minTemperatureForcast[5],
                                  _data.mixTemperatureForcast[5]),
                              forcastElement(
                                  7,
                                  _data.abbreviationForcast[6],
                                  _data.minTemperatureForcast[6],
                                  _data.mixTemperatureForcast[6]),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ));
  }
}

Widget forcastElement(daysFromNow, abbreviation, maxtemp, mintemp) {
  var now = new DateTime.now();
  var oneDayFromNow = now.add(new Duration(days: daysFromNow));
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(285, 212, 228, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              new DateFormat.E().format(oneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              new DateFormat.MMMd().format(oneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            //   child: Image.network(abbreviation != null
            //                     ? 'https://www.metaweather.com/static/img/weather/png/'+abbreviation +'.png':'image/180.png',
            //     width: 50,
            //   ),
            // ),
            Text(
              'High: ' + maxtemp.toString() + '\u00B0',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Low: ' + mintemp.toString() + '\u00B0C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )
          ],
        ),
      ),
    ),
  );
}
