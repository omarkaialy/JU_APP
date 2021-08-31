import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'Home.dart';

// ignore: must_be_immutable
class Results extends StatefulWidget {
  int marks;
  int wrong;
  var correctlist;
  Results(
      {required Key key,
      required this.marks,
      required this.wrong,
      required this.correctlist})
      : super(key: key);

  @override
  _ResultsState createState() => _ResultsState(marks, wrong, correctlist);
}

class _ResultsState extends State<Results> {
  int marks;
  int wrong;
  var correctlist;
  _ResultsState(this.marks, this.wrong, this.correctlist);
  int j = 0;
  int percent = 0, percent2 = 0;
  Color ourColor = Color.fromARGB(255, 154, 88, 216);
  List<String> text = ['Congratulations!!', 'You Can Do Better !!'];
  @override
  void initState() {
    super.initState();

    percent2 = ((wrong / (wrong + marks)) * 100).round();
    percent = 100 - percent2;

    if (marks < 25) {
      j = 1;
    } else {
      j = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          islamicBackground(),
          background(),
          page(),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.125.sh),
                  child: SizedBox(
                    child: Center(
                      child: CircleAvatar(
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white60,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 65,
                            child: Center(
                              child: Row(
                                children: [
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    '$marks',
                                    style: TextStyle(
                                        fontSize: 70.sp,
                                        color: Color.fromRGBO(154, 88, 216, 1)),
                                  ),
                                  Text(
                                    '  pts',
                                    style: TextStyle(
                                        fontSize: 40.sp,
                                        color: Color.fromRGBO(154, 88, 216, 1)),
                                  ),
                                  Spacer(flex: 1)
                                ],
                              ),
                            ),
                          ),
                        ),
                        radius: 90,
                        backgroundColor: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container background() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 0.5.sh,
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
        ],
      ),
    );
  }

  Card quizBox() {
    return Card(
      margin: EdgeInsets.only(
        left: 0.08.sw,
        right: 0.08.sw,
        top: 0.25.sh,
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 0.25.sh,
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
            SizedBox(height: 0.01.sh),
            //Question counter
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      '$percent %',
                      style: TextStyle(fontSize: 40.sp, color: ourColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.01.sw),
                      child: Text(
                        'Correct',
                        style: TextStyle(fontSize: 20.sp, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      '${marks + wrong}',
                      style: TextStyle(fontSize: 40.sp, color: ourColor),
                    ),
                    Text(
                      'Total Question',
                      style: TextStyle(fontSize: 20.sp, color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              )
            ]),
            SizedBox(height: 0.045.sh),
            //Quetion text
            Row(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        '$marks',
                        style: TextStyle(
                            fontSize: 40.sp, color: Colors.greenAccent[700]),
                      ),
                      Text(
                        'Correct',
                        style: TextStyle(
                            fontSize: 20.sp, color: Colors.green[500]),
                      )
                    ],
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(
                        '$wrong',
                        style: TextStyle(
                            fontSize: 40.sp, color: Colors.redAccent[700]),
                      ),
                      Text(
                        'wrong',
                        style:
                            TextStyle(fontSize: 20.sp, color: Colors.red[500]),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

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
              quizBox(),
              //white timer container
            ],
          ),
          SizedBox(
            height: 0.15.sh,
          ),
          Row(
            children: [
              Spacer(),
              Column(
                children: [
                  FlatButton(
                    onPressed: () {
                      Share.share('لقد حققت $marks اجابة صحيحة في الاختبار');
                    },
                    child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        )),
                  ),
                  Text(
                    'مشاركة النتيجة',
                    style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.brown[400],
                      child: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  Text('رؤية الاجوبة الصحيحة',
                      style: TextStyle(color: Colors.black, fontSize: 20.sp)),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.home),
                    ),
                  ),
                  Text('الصفحة الرئيسية',
                      style: TextStyle(color: Colors.black, fontSize: 20.sp)),
                ],
              ),
              Spacer()
            ],
          )
        ],
      ),
    );
  }

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
}
