import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _numQuestions = 1;
  final int _totalNumQuestions = DataSource.questionAnswers.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 43, 68, 1.0),
      body: Container(
        margin: EdgeInsets.only(top: 70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height:25.0),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Text(
                "COVID-19 Information",
                style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height:4.0),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Text(
                "Questions",
                style: TextStyle(fontSize: 44.0, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/1.4,
                    height: 5.0,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      value: (_numQuestions/_totalNumQuestions) * 1.0,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "$_numQuestions ", style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.w800)),
                        TextSpan(text: "/ $_totalNumQuestions", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}