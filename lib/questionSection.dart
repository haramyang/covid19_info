import 'package:flutter/material.dart';
import 'package:covid19_info/questionPage.dart';

class QuestionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
      height: 140.0,
      child: Container(
        child: Card(
          color: Color.fromRGBO(34, 43, 68, 1.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage()));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(width: 60.0),
                Container(
                  //color: Colors.red,
                  width: 230.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Common Questions",
                          style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Text(
                          "Contains several questions and answers for COVID-19",
                          style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}