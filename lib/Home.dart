import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'QuizBrain.dart';
import 'results.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 1;
  bool cancelTimer = false;
  int marks = 0;
  int timer = 30;
  String showTimer = '30';
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    startTimer();
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
      minWidth: 225,
      height: 40,
      color: Color.fromRGBO(255, 253, 255, 99),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: btnColor[k],
          width: 2,
        ),
      ),
      onPressed: () {
        checkAnswer(k);
        setState(() {});
      },
      child: Text(
        QuizBrain.omar[i.toString()][k].toString(),
        textDirection: TextDirection.rtl,
      ),
      highlightColor: Colors.indigoAccent,
      splashColor: Colors.indigo[800],
    );
  }

  // functions
  // to check if the answer is right or wrong
  void checkAnswer(String k) {
    setState(() {
      if (k == QuizBrain.ans[i - 1]) {
        marks++;
        btnColor[k] = Colors.green;
      } else {
        btnColor[k] = Colors.red;
      }
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), nextQuiz);
  }

  // to start the timer
  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer <= 1) {
          t.cancel();
          nextQuiz();
          startTimer();
        } else if (cancelTimer == true) {
        } else {
          timer--;
        }
        showTimer = timer.toString();
      });
    });
  }

  // play sounds

  // to move between quizzes
  void nextQuiz() {
    cancelTimer = false;
    timer = 30;
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
              quizBox(QuizBrain.qui[i - 1].quiz, QuizBrain.qui.length),
              Container(
                child: Text(showTimer),
              ),
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
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(190, 90, 220, 50),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
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
                  onPressed: () {},
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

  Container quizBox(String a, int y) {
    Color c = Color.fromRGBO(255, 255, 255, 100);
    return Container(
      height: 240,
      //color: Color.fromRGBO(255, 255, 255, 100),
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, right: 25, top: 15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
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
                Expanded(flex: 14, child: SizedBox()),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              a,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container background() {
    return Container(
      margin: EdgeInsets.only(bottom: 450),
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
