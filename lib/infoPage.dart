import 'package:flutter/material.dart';
import 'package:covid19_info/worldDataPage.dart';

class InfoPage extends StatelessWidget {
  Color firstPageColor = Color.fromRGBO(132, 210, 230, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstPageColor,
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Image.asset(
                './images/covid19.jpg',
                width: MediaQuery.of(context).size.width/1.2,
              ),
            ),
            margin: EdgeInsets.only(top: 120.0),
          ),
          Container(
            child: Text(
              "COVID-19",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40.0),
            width: MediaQuery.of(context).size.width/1.2,
            child: Center(
              child: Text(
                "This application will inform you about the current COVID-19 pandemic. "
                    "Hope this can be informative and helpful!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80.0),
            height: 60.0,
            width: MediaQuery.of(context).size.width/1.7,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
              ),
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    WorldDataPage()), (Route<dynamic> route) => false);
              },
              color: Colors.white,
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontWeight: null,
                  fontSize: 24,
                  color: firstPageColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}