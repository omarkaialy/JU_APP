import 'package:audioplayers/audio_cache.dart';

import 'QuizBrain.dart';
import 'results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int questionCounter = 1;
  int streak = 0;
  int marks = 0;
  int wrongAnswers = 0;
  String answer = '';
  late String correctAns;
  Color ourColor = Color.fromARGB(255, 154, 88, 216);
  CountDownController _controller = CountDownController();

  String boolean = '';
  int buttonDisabled = 1;
  bool buttonClicked = false;
  final assetsAudioPlayer = AudioCache();

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
            height: 0.12.sh,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              quizBox(
                QuizBrain.qui[questionCounter - 1].quiz,
                QuizBrain.qui.length,
              ),
              Container(
                width: 0.15.sw,
                height: 0.15.sw,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: ourColor,
                      //offset: Offset.fromDirection(50),
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularCountDownTimer(
                    width: 0.50.sw,
                    height: 0.12.sh,
                    isReverse: true,
                    isReverseAnimation: true,
                    controller: _controller,
                    duration: 30,
                    onComplete: () {
                      nextQuiz();
                      resetButtonsColors();
                      buttonDisabled++;
                      playSound(0);
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
            height: 0.04.sh,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                choiceButton('a'),
                choiceButton('b'),
                choiceButton('c'),
                choiceButton('d'),
                SizedBox(height: 0.015.sh),
                Row(
                  children: [
                    SizedBox(width: 0.05.sw),
                    Expanded(
                      child: TextButton(
                        onPressed: (buttonDisabled == 1)
                            ? null
                            : () {
                                setState(() {
                                  if (questionCounter > 1) {
                                    previousQuiz();
                                    resetButtonsColors();
                                    showBtnColors();
                                    _controller.pause();
                                  } else {
                                    showMessage('لا يوجد سؤال سابق');
                                  }
                                });
                              },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromRGBO(190, 90, 220, 50),
                        ),
                      ),
                    ),
                    //SizedBox(width: 2.sw),
                    Expanded(
                      child: MaterialButton(
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.all(
                        //     Color.fromRGBO(220, 175, 255, 80),
                        //   ),
                        //   elevation: MaterialStateProperty.all(3),
                        //   side: MaterialStateProperty.all(
                        //     BorderSide(
                        //       color: Color.fromRGBO(190, 90, 220, 50),
                        //       width: 1.5,
                        //     ),
                        //   ),
                        //   shape: MaterialStateProperty.all(
                        //     RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //   ),
                        // ),
                        minWidth: 0.10.sw,
                        height: 0.06.sh,
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
                          'Check Answer',
                          style: TextStyle(
                            color: Color.fromRGBO(190, 90, 220, 50),
                            fontSize: 0.026.sw,
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
                              showMessage('لقد اجبت عن هذا السؤال مسبقا');
                            } else
                              showMessage('اختر إجابة');
                          });
                        },
                      ),
                    ),
                    //SizedBox(width: 2.sw),
                    Expanded(
                      child: TextButton(
                        onPressed: (questionCounter >= buttonDisabled)
                            ? () {
                                showMessage('اختر إجابة');
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
                    SizedBox(width: 0.05.sw),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.01.sh,
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
      child: Column(
        children: [
          Container(
            height: 0.32.sh,
            //margin: EdgeInsets.only(bottom: 68.sh),
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
        padding: EdgeInsets.only(
          left: 0.05.sw,
          right: 0.05.sw,
          top: 0.02.sh,
          bottom: 0.02.sh,
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        wrongAnswers.toString(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.015.sh,
            ),
            Center(
              child: Text(
                'question $questionCounter / $totalQuestions',
                style: TextStyle(
                  color: ourColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 0.015.sh,
            ),
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
                  fontSize: 15,
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
      height: 0.07.sh,
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
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      highlightColor: ourColor,
      splashColor: ourColor,
    );
  }

  // functions

  // TODO: Toast function
  void showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        webPosition: "center",
        backgroundColor: ourColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

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
      if (newanswer == QuizBrain.ans[questionCounter - 1]) {
        marks++;
        streak++;
        playSound(1);
      } else {
        wrongAnswers++;
        streak = 0;
        playSound(0);
      }
      showBtnColors();
      _controller.restart();

      _controller.pause();
      buttonDisabled++;
      answer = '';
      if (streak % 10 == 0 && streak > 0) {
        playSound(2);
        showMessage('$streak اجابة صحيحة متتالية');
      }
    });
  }

  //TODO: play sounds
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
        _controller.resume();
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
