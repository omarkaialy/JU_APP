import 'package:flutter/material.dart';

import 'QuizPage.dart';
import 'quizbrain.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
          ),
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage.withoutLocatio(
                              key: Key('key1'),
                              map: QuizBrain.qui,
                              answerslist: QuizBrain.omar,
                              correctanswers: QuizBrain.ans,
                            )));
              },
              child: Container(
                child: Text('data'),
              ))
        ],
      ),
    );
  }
}
