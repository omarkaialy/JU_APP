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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment(-0.1, -0.5),
          children: [
            Background(),
            page(),
          ],
        ));
  }

  //to decide what the color of the button
  var btncolor = {
    'a': Colors.indigo,
    'b': Colors.indigo,
    'c': Colors.indigo,
    'd': Colors.indigo
  };
// button creater
//TODO  تعديل هدول الزرين ليصيرو متل يلي ب الصورة يلي شفناها
  MaterialButton choicebutton(String k) {
    return MaterialButton(
      minWidth: 200,
      height: 50,
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
            alignment: Alignment.topCenter,
            children: [
              quizbox(Quizbrain.qui[i - 1].quiz, Quizbrain.qui.length),
              Container(
                child: Text(showtimer),
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
                  color: Colors.indigo,
                  onPressed: () {},
                  child: Text('data'),
                ),
              ),
              VerticalDivider(
                width: 3,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.indigo,
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
      height: 250,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            height: 25,
            child: Row(
              children: [
                Expanded(
                  child: Text('right'),
                  flex: 3,
                ),
                Expanded(flex: 18, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Text('wrong'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text('question $i / $y'),
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
      margin: EdgeInsets.only(bottom: 550),
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
