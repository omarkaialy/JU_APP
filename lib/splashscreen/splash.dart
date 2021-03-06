import 'package:flutter/material.dart';
import 'package:ju_app/Home.dart';
import 'animation_screen.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Scaffold(body: Home()),
      IgnorePointer(
          child: Stack(children: [
        AnimationScreen(color: Colors.purple),
      ])),
    ]));
  }
}
