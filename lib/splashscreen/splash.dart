import 'package:flutter/material.dart';
import 'animation_screen.dart';
import '../Home.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Scaffold(body: Home()),
      IgnorePointer(
          child: Stack(children: [
        AnimationScreen(color: Color.fromRGBO(154, 88, 216, 1)),
      ])),
    ]));
  }
}
