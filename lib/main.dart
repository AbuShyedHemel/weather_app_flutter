import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dataHelper/datHelper.dart';
import 'package:weather_app/screens/mainpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp((ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  )));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}
