import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  int marks;
  Results({required Key key, required this.marks}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState(marks);
}

class _ResultsState extends State<Results> {
  int marks;
  _ResultsState(this.marks);
  int j = 0;
  List<String> text = ['Congratulations!!', 'You Can Do Better !!'];
  @override
  void initState() {
    super.initState();
    if (marks < 25) {
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
                child: TextButton(
                  onPressed: () {},
                  child: Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
