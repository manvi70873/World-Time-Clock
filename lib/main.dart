import 'package:flutter/material.dart';
import 'package:time_zone_app/pages/myapifile.dart';
import 'api.dart' as util;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Myapifile(continentname: util.continent,countryname: util.country,),
    );
  }
}
