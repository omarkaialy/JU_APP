import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'QuizBrain.dart';
import 'results.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 1;
  int marks = 0;
  String answer = '';
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment(-0.1, -0.5),
        children: [
          background(),
          page(),
        ],
      ),
    );
  }

  //to decide what the color of the button
  var btnColor = {
    'a': Colors.black45,
    'b': Colors.black45,
    'c': Colors.black45,
    'd': Colors.black45,
  };

  // button creator
  MaterialButton choiceButton(String k) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 18,
      color: Color.fromRGBO(255, 253, 255, 99),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: btnColor[k]!,
          width: 2,
        ),
      ),
      onPressed: () {
        answer = k;
      },
      child: Text(
        QuizBrain.omar[i.toString()]![k].toString(),
        textDirection: TextDirection.rtl,
      ),
      highlightColor: Colors.indigoAccent,
      splashColor: Colors.indigo[800],
    );
  }

  // functions
  // to check if the answer is right or wrong
  void checkAnswer(String o) {
    setState(() {
      if (o == QuizBrain.ans[i - 1]) {
        marks++;
        btnColor[o] = Colors.green;
      } else {
        btnColor[o] = Colors.red;
      }
    });
  }

  // play sounds

  // to move between quizzes
  void nextQuiz() {
    setState(() {
      if (i < 100) {
        i++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => results(marks: marks),
          ),
        );
      }
      btnColor['a'] = Colors.black45;
      btnColor['b'] = Colors.black45;
      btnColor['c'] = Colors.black45;
      btnColor['d'] = Colors.black45;
    });
  }

  //UI
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
              quizbox(QuizBrain.qui[i - 1].quiz, QuizBrain.qui.length),
              Container(
                  child: CircularCountDownTimer(
                      width: MediaQuery.of(context).size.width / 2,
                      isReverse: true,
                      isReverseAnimation: true,
                      controller: _controller,
                      height: MediaQuery.of(context).size.height / 12,
                      duration: 30,
                      onComplete: () {
                        nextQuiz();
                        _controller.restart();
                      },
                      backgroundColor: Colors.white,
                      strokeCap: StrokeCap.round,
                      fillColor: Color.fromARGB(255, 154, 88, 216),
                      ringColor: Colors.white)),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                choiceButton('a'),
                choiceButton('b'),
                choiceButton('c'),
                choiceButton('d')
              ],
            ),
          ),
          Row(
            //TODO 1 بدنا نعدل هدول الزرين ل يصيرو next back
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (i > 1) {
                        i--;
                      }
                    });
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(190, 90, 220, 50),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    checkAnswer(answer);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(220, 175, 255, 80),
                      ),
                      elevation: MaterialStateProperty.all(3),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Color.fromRGBO(190, 90, 220, 50),
                          width: 1.5,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  child: Text(
                    'Check Answer',
                    style: TextStyle(
                      color: Color.fromRGBO(190, 90, 220, 50),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      nextQuiz();
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(190, 90, 220, 50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card quizbox(String a, int y) {
    return Card(
      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height / 3.4,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }

  Container background() {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        image: DecorationImage(
          image: AssetImage(
            'images/purple-background-1.0.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
