import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_info/countryData.dart';

class LatestUpdateSection extends StatefulWidget {

  LatestUpdateSection({Key key, this.futureCountryData}) : super(key: key);
  final Future<CountryData> futureCountryData;

  @override
  _LatestUpdateSectionState createState() => _LatestUpdateSectionState();
}

class _LatestUpdateSectionState extends State<LatestUpdateSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            "COVID-19 Latest Update",
            style: dropDownSelectedText,
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          child: FutureBuilder<CountryData>(
            future: widget.futureCountryData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    infoBox("Infected", 57669, snapshot.data.infected, Colors.orange),
                    infoBox("Recovered", 59517, snapshot.data.recovered, Colors.green),
                    infoBox("Dead", 58829, snapshot.data.death, Colors.red),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
        SizedBox(height: 40.0),
      ],
    );
  }

  Widget infoBox(String boxType, int iconCode, int typeCount, Color color) {
    return Center(
      child: Container(
        height: 150.0,
        width: (MediaQuery.of(context).size.width - 40.0)/3.3,
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color)
                ),
                child: Icon(
                  IconData(iconCode, fontFamily: 'MaterialIcons'),
                  color: color,
                ),
              ),
              /*Icon(
                IconData(iconCode, fontFamily: 'MaterialIcons'),
                color: color,
              ),*/
              SizedBox(height: 20.0),
              AutoSizeText(
                '$typeCount',
                style: TextStyle(color: color, fontSize: 30.0, fontWeight: FontWeight.w600),
                maxLines: 1,
              ),
              Text(
                boxType,
                style: TextStyle(color: Colors.black45, fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}