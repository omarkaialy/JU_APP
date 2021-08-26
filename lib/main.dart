import 'package:flutter/material.dart';
import 'Home.dart';
import 'splash.dart';

void main() => runApp(MyApp(key: Key('key'),));

class MyApp extends StatefulWidget {
  MyApp({required Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO: add an appBar with action & leading
      debugShowCheckedModeBanner: false,
      home: Home(key: Key('key'),),
    );
  }
}
