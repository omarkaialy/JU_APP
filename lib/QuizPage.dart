// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayers/audio_cache.dart';
import 'dart:ui';

import 'results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizPage extends StatefulWidget {
  var map;
  var answerslist;
  var correctanswers;
  QuizPage.without(Key key);
  QuizPage.withoutLocatio(
      {required Key key,
      required this.map,
      required this.answerslist,
      required this.correctanswers})
      : super(key: key);

  @override
  _QuizPageState createState() =>
      _QuizPageState(map, answerslist, correctanswers);
}

class _QuizPageState extends State<QuizPage> {
  //vriables:
  var map;
  var answerslist;
  var correctanswers;
  _QuizPageState(this.map, this.answerslist, this.correctanswers);

  String answer = '';
  String boolean = '';
  //to set a color for each button
  var btnColor = {
    'a': Colors.white12,
    'b': Colors.white12,
    'c': Colors.white12,
    'd': Colors.white12,
  };
  bool buttonClicked = false;
  int buttonDisabled = 1;
  late String correctAns;
  int marks = 0;
  Color ourColor = Color.fromARGB(255, 154, 88, 216);
  Color timerColor = Color.fromARGB(255, 154, 88, 216);
  //TODO: timerColor = (_controller.getTime() <= 5) ? ourColor : Colors.red
  int questionCounter = 1;
  int streak = 0;
  int wrongAnswers = 0;
  final assetsAudioPlayer = AudioCache();
  CountDownController _controller = CountDownController();
  //end variables

  //Quiz Page UI
  Container page() {
    return Container(
      //main column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 0.12.sh,
          ),
          //for timer
          Stack(
            alignment: Alignment.topCenter,
            children: [
              quizBox(
                map[questionCounter - 1].quiz,
                map.length,
              ),
              //white timer container
              Container(
                width: 0.195.sw,
                height: 0.195.sw,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: ourColor,
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.0065.sh),
                  //timer
                  child: CircularCountDownTimer(
                    width: 0.50.sw,
                    height: 0.12.sh,
                    isReverse: true,
                    isReverseAnimation: true,
                    controller: _controller,
                    duration: 30,
                    onComplete: () {
                      nextQuiz();
                      answer = '';
                      resetButtonsColors();
                      buttonDisabled++;
                      playSound(0);
                      wrongAnswers++;
                      _controller.restart();
                    },
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 0.045.sw,
                      color: timerColor,
                    ),
                    backgroundColor: Colors.white,
                    strokeCap: StrokeCap.butt,
                    strokeWidth: 5,
                    fillColor: timerColor,
                    ringColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.04.sh),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                choiceButton('a'),
                choiceButton('b'),
                choiceButton('c'),
                choiceButton('d'),
                SizedBox(height: 0.012.sh),
                //down row (controlling buttons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: TextButton(
                        onPressed: () {
                          if (questionCounter == 1) {
                            showMessage('???? ???????? ???????? ????????', Colors.red);
                          }
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
                          Icons.arrow_forward_ios,
                          color: ourColor,
                          size: 60.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (0.075.sw),
                        vertical: (0.sh),
                      ),
                      child: MaterialButton(
                        minWidth: 0.30.sw,
                        height: 0.055.sh,
                        color: Color.fromRGBO(220, 175, 255, 80),
                        elevation: 10,
                        disabledElevation: 3,
                        disabledColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: ourColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '????????',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ourColor,
                            fontSize: 0.045.sw,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (buttonDisabled == questionCounter &&
                                answer != '') {
                              checkAnswer(answer);
                              showBtnColors();
                              buttonClicked = false;
                            } else if (buttonDisabled > questionCounter) {
                              showMessage('??????  ???????? ???? ?????? ???????????? ??????????',
                                  Colors.green);
                            } else
                              showMessage('???????? ??????????', Colors.grey);
                          });
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: (questionCounter >= buttonDisabled)
                          ? () {
                              showMessage(
                                  '???????? ?????????????? ?????? ???????????????? ?????? ???????????? ????????????',
                                  Colors.grey);
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
                        color: ourColor,
                        size: 60.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.015.sh,
          ),
        ],
      ),
    );
  }

  //white Islamic background
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
      child: Column(
        children: [
          Container(
            height: 0.32.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 0.68.sh,
          ),
        ],
      ),
    );
  }

  //quiz box
  //TODO: edit the height of quizBox (make it flexible) to avoid overflow pixels
  Card quizBox(String question, int totalQuestions) {
    return Card(
      margin: EdgeInsets.only(
        left: 0.08.sw,
        right: 0.08.sw,
        top: 0.05.sh,
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 0.3.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 0.05.sw,
          vertical: 0.025.sh,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: ourColor,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            //correct & wrong answers counters
            Container(
              height: 0.04.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.04.sw,
                  vertical: 0.sh,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        marks.toString(),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 0.045.sw,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        wrongAnswers.toString(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 0.045.sw,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.015.sh),
            //Question counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Question ',
                  style: TextStyle(
                    color: ourColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 00.04.sw,
                  ),
                ),
                Text(
                  '$questionCounter ',
                  style: TextStyle(
                    color: ourColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 00.055.sw,
                  ),
                ),
                Text(
                  '/ $totalQuestions',
                  style: TextStyle(
                    color: ourColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 00.04.sw,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.015.sh),
            //Quetion text
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (0.03.sw),
                vertical: (0.sh),
              ),
              child: Text(
                question,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 0.0384.sw,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // button creator
  MaterialButton choiceButton(String buttonKey) {
    return MaterialButton(
      minWidth: 0.68.sw,
      height: 0.058.sh,
      color: Colors.white,
      elevation: 10,
      disabledElevation: 3,
      disabledColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: btnColor[buttonKey]!,
          width: 2.5,
        ),
      ),
      onPressed: () {
        // this condition is to ensure that answerd Q buttons are diasabled
        if (questionCounter >= buttonDisabled) {
          answer = buttonKey;
          correctAns = correctanswers[questionCounter - 1];
          setState(() {
            buttonClicked = true;
            resetButtonsColors();
            btnColor[buttonKey] = ourColor;
          });
        }
      },
      // choices
      child: Text(
        answerslist[questionCounter.toString()]![buttonKey].toString(),
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 0.0365.sw,
          fontWeight: FontWeight.bold,
        ),
      ),
      highlightColor: ourColor,
      splashColor: ourColor,
    );
  }

  // functions

  // Toast message
  void showMessage(String message, Color kColor) {
    FToast().init(context).showToast(
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(milliseconds: 1500),
        child: Container(
            decoration: BoxDecoration(
              color: kColor,
              borderRadius: BorderRadius.circular(40),
            ),
            height: 0.04.sh,
            width: 0.5.sw,
            child: Center(
              child: Text(message,
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            )));
  }

  //resetting choice buttons colors
  void resetButtonsColors() {
    btnColor = {
      'a': Colors.white12,
      'b': Colors.white12,
      'c': Colors.white12,
      'd': Colors.white12,
    };
  }

  // to check if the answer is right or wrong
  void checkAnswer(String newAnswer) {
    setState(() {
      if (newAnswer == correctanswers[questionCounter - 1]) {
        marks++;
        streak++;
        playSound(1);
        HapticFeedback.vibrate();
      } else {
        wrongAnswers++;
        streak = 0;
        playSound(0);
        HapticFeedback.vibrate();
      }
      showBtnColors();
      _controller.pause();
      buttonDisabled++;
      answer = '';
      if (streak % 10 == 0 && streak > 0) {
        playSound(2);
        showMessage('$streak ?????????? ?????????? ??????????????', Colors.green);
      }
    });
  }

  // play sounds
  void playSound(int i) {
    if (i == 1) {
      assetsAudioPlayer.play('sounds/Correct.mp3');
    } else if (i == 2) {
      assetsAudioPlayer.play('sounds/clapping.wav');
    } else
      assetsAudioPlayer.play('sounds/Wrong.mp3');
  }

  // show all buttons' colors
  void showBtnColors() {
    btnColor[correctanswers[questionCounter - 1]] = Colors.green;
    if (answer != correctanswers[questionCounter - 1])
      btnColor[answer] = Colors.red;
  }

  // to move to next quiz
  void nextQuiz() {
    setState(() {
      if (questionCounter < map.length) {
        questionCounter++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Results(
              marks: marks,
              key: Key('key2'),
              wrong: wrongAnswers,
              correctlist: correctanswers,
            ),
          ),
        );
      }
      _controller.restart();
      btnColor['a'] = Colors.black45;
      btnColor['b'] = Colors.black45;
      btnColor['c'] = Colors.black45;
      btnColor['d'] = Colors.black45;
      if (questionCounter >= buttonDisabled) {
        _controller.resume();
      }
    });
  }

  // to move to previous quiz
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

  // build method
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
}
