import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'Home.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
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
            child: Home(key: Key('key'),),),
      );
    });
    this.animationController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
    );
    this.animation = Tween<double>(begin: 0.0, end: 1.0).animate(this.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 154, 88, 216),
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('طريقك لترفيع المهارات',textDirection: TextDirection.rtl,),
            SizedBox(height: 25),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: TextLiquidFill(
                  boxHeight: 300,
                  text: 'JU APP',
                  textStyle: TextStyle(color: Colors.white, fontSize: 45),
                  boxBackgroundColor:  Color.fromARGB(255, 154, 88, 216),
                  waveColor: Colors.yellowAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
