import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'Home.dart';

class splash extends StatefulWidget {
  splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(seconds: 2),
            child: Home()),
      );
    });
    this.animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    this.animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(this.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('طريقك لترفيع المهارات'),
            SizedBox(height: 25),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: TextLiquidFill(
                  boxHeight: 300,
                  text: 'JU APP',
                  textStyle: TextStyle(color: Colors.white, fontSize: 45),
                  boxBackgroundColor: Colors.indigo,
                  waveColor: Colors.yellowAccent,
                )),
          ]),
        ),
      ),
    );
  }
}
