import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const TextStyle regularText =  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);
const TextStyle dropDownSelectedText = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black);
const TextStyle dropDownItemText = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black87);

class WorldDataPage extends StatefulWidget {
  @override
  _WorldDataPageState createState() => _WorldDataPageState();
}

class _WorldDataPageState extends State<WorldDataPage> {

  String _country = "United States of America";

  _updateCountry(String newCountry) {
    setState((){
      _country = newCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0),
          child: Column(
            children: <Widget>[
              HeaderSection(isWorld: true, countryCallBack: _updateCountry,),
              QuestionSection(),
              LatestUpdateSection(country: _country),
            ],
          ),
        ),
    );
  }
}

class LatestUpdateSection extends StatefulWidget {

  LatestUpdateSection({Key key, this.country}) : super(key: key);
  final String country;

  @override
  _LatestUpdateSectionState createState() => _LatestUpdateSectionState();
}

class _LatestUpdateSectionState extends State<LatestUpdateSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.country),
        Container(
          child: Text(
            "COVID-19 Latest Update",
            style: dropDownSelectedText,
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              infoBox("Infected", 57669, 790, Colors.orange),
              infoBox("Recovered", 59517, 80, Colors.green),
              infoBox("Dead", 58829, 100, Colors.red),
            ],
          ),
        ),
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
              Text(
                '$typeCount',
                style: TextStyle(color: color, fontSize: 30.0, fontWeight: FontWeight.w600),
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

class QuestionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
      height: 140.0,
      child: Container(
        child: Card(
          color: Color.fromRGBO(34, 43, 68, 1.0),
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
    );
  }
}


class HeaderSection extends StatefulWidget {
  HeaderSection({Key key, this.isWorld, this.countryCallBack}) : super(key: key);
  final bool isWorld;
  final ValueChanged<String> countryCallBack;

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection>{

  String _selectedVal = 'United States of America';
  var dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var date = new DateFormat.yMMMMEEEEd().format(dt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            (widget.isWorld ? "World " : "US ") + "Current Outbreak",
            style: regularText,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.0),
          width: double.infinity,
          height: 35.0,
          child: DropdownButton<String>(
            //hint: Text("Select a country", style: dropDownSelectedText),
            isExpanded: true,
            underline: Container(),
            value: _selectedVal,
            selectedItemBuilder: (BuildContext context) {
              return DataSource.countries.map<Widget>((String country) {
                return Text(country, style: dropDownSelectedText);
              }).toList();
            },
            items: DataSource.countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: dropDownItemText),
              );
            }).toList(),
            onChanged: (newVal) {
              widget.countryCallBack(newVal);
              setState(() {
                _selectedVal = newVal;
              });
            },
          ),
        ),
        Container(
          child: Text(
            date,
            style: regularText,
          ),
        ),
      ],
    );
  }
}