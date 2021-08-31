import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ju_app/QuizPage.dart';
import 'package:ju_app/quizbrain.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purpleAccent,
        child: Row(
          children: [
            Spacer(),
            Column(
              children: [
                SizedBox(
                  height: 0.25.sh,
                ),
                FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    child: containers(Colors.blue, 'الملخص')),
                SizedBox(
                  height: 0.035.sh,
                ),
                FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    child: containers(Colors.green, 'الدوارت'))
              ],
            ),
            Spacer(),
            Column(
              children: [
                SizedBox(
                  height: 0.35.sh,
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage.withoutLocatio(
                                key: Key('key3'),
                                map: QuizBrain.qui,
                                answerslist: QuizBrain.omar,
                                correctanswers: QuizBrain.ans)));
                  },
                  child: containers(Colors.red, 'الاختبار الشامل'),
                ),
              ],
            ),
            Spacer()
          ],
        ));
  }

  Stack containers(Color kColor, String kText) {
    return Stack(
      alignment: Alignment.bottomLeft,
      fit: StackFit.passthrough,
      children: [
        Container(
          width: 0.4.sw,
          height: 0.25.sh,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          decoration: BoxDecoration(
              color: kColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20)),
          width: 0.3.sw,
          height: 0.13.sh,
        ),
        Container(
          margin: EdgeInsets.only(left: 0.15.sw, bottom: 0.1.sh),
          decoration: BoxDecoration(
              color: kColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20)),
          width: 0.25.sw,
          height: 0.296.sw,
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                kText,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 30.sp,
                    color: Colors.black),
              ),
            ))
      ],
    );
  }
}
