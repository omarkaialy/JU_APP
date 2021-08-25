import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'quizbrain.dart';
import 'results.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 1;
  bool canceltimer = false;
  int marks = 0;

  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Background(),
            page(),
          ],
        ));
  }

  //to decide what the color of the button
  var btncolor = {
    'a': Color.fromRGBO(159, 88, 216, 1),
    'b': Color.fromRGBO(159, 88, 216, 1),
    'c': Color.fromRGBO(159, 88, 216, 1),
    'd': Color.fromRGBO(159, 88, 216, 1)
  };
// button creater
//TODO  تعديل هدول الزرين ليصيرو متل يلي ب الصورة يلي شفناها
  MaterialButton choicebutton(String k) {
    return MaterialButton(
      minWidth: MediaQuery.maybeOf(context)!.textScaleFactor,
      height: 50,
      onPressed: () {
        checkanswer(k);
        setState(() {});
      },
      child: Text(Quizbrain.omar[i.toString()]![k].toString()),
      color: btncolor[k],
      highlightColor: Color.fromRGBO(159, 88, 216, 1),
      splashColor: Color.fromRGBO(159, 88, 216, 1),
    );
  }

// functions
// to check if the answer is right or wrong
  void checkanswer(String k) {
    setState(() {
      if (k == Quizbrain.ans[i - 1]) {
        marks++;
        btncolor[k] = Colors.green;
      } else {
        btncolor[k] = Colors.red;
      }
      canceltimer = true;
    });
  }

// play sounds

// to move between quizzes
  void nextquiz() {
    canceltimer = false;

    setState(() {
      if (i < 100) {
        i++;
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => results(marks: marks)));
      }
      btncolor['a'] = Color.fromRGBO(159, 88, 216, 1);
      btncolor['b'] = Color.fromRGBO(159, 88, 216, 1);
      btncolor['c'] = Color.fromRGBO(159, 88, 216, 1);
      btncolor['d'] = Color.fromRGBO(159, 88, 216, 1);
    });
  }

  Container page() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 150,
          ),
          Stack(
            alignment: Alignment(0, -1.25),
            children: [
              quizbox(Quizbrain.qui[i - 1].quiz, Quizbrain.qui.length),
              CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 4,
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                    color: Color.fromRGBO(159, 88, 216, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                height: MediaQuery.of(context).size.height / 12,
                duration: 30,
                fillColor: Color.fromRGBO(159, 88, 216, 1),
                isReverse: true,
                isReverseAnimation: true,
                strokeWidth: 3.5,
                controller: _controller,
                ringColor: Colors.white,
                onComplete: () {
                  nextquiz();
                  _controller.restart();
                },
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                choicebutton('a'),
                choicebutton('b'),
                choicebutton('c'),
                choicebutton('d')
              ],
            ),
          ),
          Row(
            //TODO 1 بدنا نعدل هدول الزرين ل يصيرو next back
            children: [
              Expanded(
                child: MaterialButton(
                  color: Color.fromRGBO(159, 88, 216, 1),
                  onPressed: () {},
                  child: Text('data'),
                ),
              ),
              VerticalDivider(
                width: 3,
              ),
              Expanded(
                child: MaterialButton(
                  color: Color.fromRGBO(159, 88, 216, 1),
                  onPressed: () {},
                  child: Text('data'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container quizbox(String a, int y) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.4,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            height: 25,
            child: Row(
              children: [
                Expanded(
                  child: Text(marks.toString(),
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  flex: 3,
                ),
                Expanded(flex: 18, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Text(
                    marks.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              'question $i / $y',
              style: TextStyle(color: Color.fromARGB(255, 159, 88, 216)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(a),
          )
        ],
      ),
    );
  }

  Container Background() {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        image: DecorationImage(
            image: AssetImage(
              'images/image.jpg',
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
