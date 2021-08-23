import 'dart:async';

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
  int timer = 30;
  String showtimer = '30';

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.indigo,
              child: Row(
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Center(
                          child: Text(
                            'Score : $marks',
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Expanded(
                        child: Center(
                          child: Text(
                            '    question $i/100',
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(flex: 1, child: Text(showtimer))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  child: Text(
                Quizbrain.qui[i - 1].quiz,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.right,
              ))),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                choicebutton('a'),
                choicebutton('b'),
                choicebutton('c'),
                choicebutton('d')
              ],
            ),
          ),
        ]),
      ),
    );
  }

  //to decide what the color of the button
  var btncolor = {
    'a': Colors.indigo,
    'b': Colors.indigo,
    'c': Colors.indigo,
    'd': Colors.indigo
  };
// button creater
  MaterialButton choicebutton(String k) {
    return MaterialButton(
      minWidth: 200,
      height: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
      onPressed: () {
        checkanswer(k);
        setState(() {});
      },
      child: Text(Quizbrain.omar[i.toString()]![k].toString()),
      color: btncolor[k],
      highlightColor: Colors.indigoAccent,
      splashColor: Colors.indigo[800],
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
    Timer(Duration(seconds: 1), nextquiz);
  }

// to start the timer
  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer <= 1) {
          t.cancel();
          nextquiz();
          starttimer();
        } else if (canceltimer == true) {
        } else {
          timer--;
        }
        showtimer = timer.toString();
      });
    });
  }

// play sounds

// to move between quizzes
  void nextquiz() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (i < 100) {
        i++;
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => results(marks: marks)));
      }
      btncolor['a'] = Colors.indigo;
      btncolor['b'] = Colors.indigo;
      btncolor['c'] = Colors.indigo;
      btncolor['d'] = Colors.indigo;
    });
  }
}
