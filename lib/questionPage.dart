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

  ScrollController _controller;

  _scrollListener() {
    var currPos = _controller.position.pixels;
    var endPos = _controller.position.maxScrollExtent;
    var offset = endPos/_totalNumQuestions;
    if(currPos > 0 && currPos < endPos) {
      setState(() {
        _numQuestions = (currPos/offset).ceil().toInt();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

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
                        TextSpan(text: "$_numQuestions", style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.w800)),
                        TextSpan(text: "/$_totalNumQuestions", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 20.0),
              child: ListView(
                controller: _controller,
                children: getQuestionCardsInArea(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Question> getQuestions() {
    List<Question> questions = [];
    for(int i = 0; i < DataSource.questionAnswers.length; ++i) {
      questions.add(Question(DataSource.questionAnswers[i]["question"], DataSource.questionAnswers[i]["answer"]));
    }

    return questions;
  }

  List<Widget> getQuestionCardsInArea() {
    List<Widget> questionCards = [];
    List<Question> questions = getQuestions();

    for(Question question in questions) {
      questionCards.add(questionCard(question));
    }

    return questionCards;
  }

  Widget questionCard(Question question) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(right: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: <Widget>[
                Text("#covid-19 ", style: TextStyle(color: Colors.black54, )),
                Text("#haramyang", style: TextStyle(color: Colors.black54, )),
              ],
            ),
          ),
          Container(
            height: 100.0,
            padding: EdgeInsets.only(bottom: 10.0),
            child: AutoSizeText(
              question.question,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              maxLines: 4,
            ),
          ),
          Container(
            //color: Colors.red,
            height: 250.0,
            child: AutoSizeText(
              "Answer: "+ question.answer,
              style: TextStyle(fontSize: 25, ),
              maxLines: 10,
              minFontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}

class Question {
  final String question;
  final String answer;

  Question(this.question, this.answer);
}