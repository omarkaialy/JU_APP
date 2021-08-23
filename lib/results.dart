import 'package:flutter/material.dart';

import 'splash.dart';

class results extends StatefulWidget {
  int marks;
  results({Key? key, required this.marks}) : super(key: key);

  @override
  _resultsState createState() => _resultsState(marks);
}

class _resultsState extends State<results> {
  int marks;
  _resultsState(this.marks);
  int j = 0;
  List<String> text = ['Congratulations!!', 'You Can Do Better !!'];
  @override
  void initState() {
    super.initState();
    if (marks < 80) {
      j = 1;
    } else {
      j = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 300,
                height: 300,
                child: Image.asset('images/image$j.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                text[j] + '\t your Score is $marks',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 2,
              child: Material(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => splash()));
                  },
                  child: Text('Continue'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
