import 'QuizBrain.dart';
import 'results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
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
            height: 12.h,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              quizBox(
                QuizBrain.qui[questionCounter - 1].quiz,
                QuizBrain.qui.length,
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: ourColor,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularCountDownTimer(
                    width: 50.w,
                    height: 12.h,
                    isReverse: true,
                    isReverseAnimation: true,
                    controller: _controller,
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
                      fontSize: 14.sp,
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
            height: 4.h,
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
            height: 3.h,
          ),
          Row(
            children: [
              SizedBox(width: 5.w),
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
              //SizedBox(width: 2.w),
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
              //SizedBox(width: 2.w),
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
              SizedBox(width: 5.w),
            ],
          ),
          SizedBox(
            height: 3.h,
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
            height: 32.h,
            //margin: EdgeInsets.only(bottom: 68.h),
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
            height: 68.h,
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
        left: 8.w,
        right: 8.w,
        top: 5.h,
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 30.h,
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 2.h,
          bottom: 2.h,
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
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 0.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        marks.toString(),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        wrongAnswers.toString(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 15.sp,
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
              height: 1.5.h,
            ),
            Center(
              child: Text(
                'question $questionCounter / $totalQuestions',
                style: TextStyle(
                  color: ourColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (3.w),
                vertical: (0.h),
              ),
              child: Text(
                question,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
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
      minWidth: 68.w,
      height: 5.5.h,
      color: Colors.white,
      elevation: 10,
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
