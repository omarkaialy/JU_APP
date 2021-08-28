import 'QuizBrain.dart';
import 'results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int questionCounter = 1;
  int marks = 0;
  int wrongAnswers = 0;
  String answer = '';
  late String correctAns;
  Color ourColor = Color.fromARGB(255, 154, 88, 216);
  CountDownController _controller = CountDownController();
  String boolean = '';
  int buttonDisabled = 1;
  bool buttonClicked = false;
  // final assetsAudioPlayer = AssetsAudioPlayer();

  //to set a color for each button
  var btnColor = {
    'a': Colors.white12,
    'b': Colors.white12,
    'c': Colors.white12,
    'd': Colors.white12,
  };

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
          islamicBackground(),
          background(),
          page(),
        ],
      ),
    );
  }

  //Quiz Page UI
  Container page() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 9,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              quizBox(
                QuizBrain.qui[questionCounter - 1].quiz,
                QuizBrain.qui.length,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.purpleAccent,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularCountDownTimer(
                    width: MediaQuery.of(context).size.width / 2,
                    isReverse: true,
                    isReverseAnimation: true,
                    controller: _controller,
                    height: MediaQuery.of(context).size.height / 12,
                    duration: 30,
                    onComplete: () {
                      nextQuiz();
                      resetButtonsColors();
                      buttonDisabled++;
                      //TODO: add Wrong audio
                      wrongAnswers++;
                      _controller.restart();
                    },
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ourColor,
                    ),
                    backgroundColor: Colors.white,
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 5,
                    fillColor: ourColor,
                    ringColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
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
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: (buttonDisabled == 1 || buttonClicked)
                      ? () {
                          // showMessage('لا يوجد سؤال سابق');
                        }
                      : () {
                          setState(() {
                            if (questionCounter > 1) {
                              previousQuiz();
                              resetButtonsColors();
                              showBtnColors();
                              _controller.pause();
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
                    ),
                  ),
                  child: Text(
                    'Check Answer',
                    style: TextStyle(
                      color: Color.fromRGBO(190, 90, 220, 50),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (buttonDisabled == questionCounter && answer != '') {
                        checkAnswer(answer);
                        showBtnColors();
                        buttonClicked = false;
                      }
                      /*else
                        showMessage('اختر إجابة');*/
                    });
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: (questionCounter >= buttonDisabled)
                      ? () {
                          // showMessage('اختر إجابة');
                        }
                      : () {
                          setState(() {
                            nextQuiz();
                            resetButtonsColors();
                            if (questionCounter != buttonDisabled)
                              showBtnColors();
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
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  //Islamic background
  Container islamicBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/islamic.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //purple background
  Container background() {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage(
            'assets/images/purple-background-1.0.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //quiz box
  //TODO: edit the height of quizBox (make it flexible) to avoid overflow pixels
  Card quizBox(String question, int totalQuestions) {
    return Card(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 15,
        right: MediaQuery.of(context).size.width / 15,
        top: MediaQuery.of(context).size.height / 23,
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.0,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height / 40,
            right: MediaQuery.of(context).size.height / 40,
            top: MediaQuery.of(context).size.height / 40,
            bottom: MediaQuery.of(context).size.height / 25),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.purpleAccent,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      marks.toString(),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      wrongAnswers.toString(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Center(
              child: Text(
                'question $questionCounter / $totalQuestions',
                style: TextStyle(
                    color: ourColor, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).textScaleFactor),
                vertical: (MediaQuery.of(context).textScaleFactor),
              ),
              child: Text(
                question,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 23),
              ),
            )
          ],
        ),
      ),
    );
  }

  // button creator
  MaterialButton choiceButton(String buttonKey) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 18,
      color: Colors.white,
      elevation: 6,
      disabledElevation: 3,
      disabledColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: btnColor[buttonKey]!,
          width: 2,
        ),
      ),
      onPressed: () {
        if (questionCounter >= buttonDisabled) {
          answer = buttonKey;
          correctAns = QuizBrain.ans[questionCounter - 1];
          setState(() {
            buttonClicked = true;
            resetButtonsColors();
            btnColor[buttonKey] = ourColor;
          });
        }
      },
      child: Text(
        QuizBrain.omar[questionCounter.toString()]![buttonKey].toString(),
        textDirection: TextDirection.rtl,
      ),
      highlightColor: ourColor,
      splashColor: ourColor,
    );
  }

  // functions

  // TODO: Toast function
  /*void showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ourColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/

  //reseting choice buttons colors
  void resetButtonsColors() {
    btnColor = {
      'a': Colors.white12,
      'b': Colors.white12,
      'c': Colors.white12,
      'd': Colors.white12,
    };
  }

  // to check if the answer is right or wrong
  void checkAnswer(String newanswer) {
    setState(() {
      if (newanswer == QuizBrain.ans[questionCounter - 1])
        marks++;
      else
        wrongAnswers++;
      showBtnColors();
      _controller.pause();
      buttonDisabled++;

      answer = '';

      //playSound();
    });
  }

  //TODO: play sounds
  /*void playSound() {
    if (answer == correctAns)
      assetsAudioPlayer.open(
        Audio("assets/sounds/Correct.mp3"),
      );
    else
      assetsAudioPlayer.open(
        Audio("assets/sounds/'Wrong.mp3"),
      );
  }*/

  // show all buttons' colors
  void showBtnColors() {
    btnColor[QuizBrain.ans[questionCounter - 1]] = Colors.green;
    if (answer != QuizBrain.ans[questionCounter - 1])
      btnColor[answer] = Colors.red;
  }

  // to move between quizzes
  void nextQuiz() {
    setState(() {
      if (questionCounter < 100) {
        questionCounter++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Results(
              marks: marks,
              key: Key('key2'),
            ),
          ),
        );
      }
      btnColor['a'] = Colors.black45;
      btnColor['b'] = Colors.black45;
      btnColor['c'] = Colors.black45;
      btnColor['d'] = Colors.black45;
      if (questionCounter >= buttonDisabled) {
        _controller.restart();
      }
    });
  }

  void previousQuiz() {
    setState(() {
      _controller.pause();
      questionCounter--;
      btnColor['a'] = Colors.black45;
      btnColor['b'] = Colors.black45;
      btnColor['c'] = Colors.black45;
      btnColor['d'] = Colors.black45;
    });
  }
}
