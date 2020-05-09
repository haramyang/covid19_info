import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:covid19_info/headerSection.dart';
import 'package:covid19_info/latestUpdate.dart';
import 'package:covid19_info/countryData.dart';
import 'package:covid19_info/questionSection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldDataPage extends StatefulWidget {
  @override
  _WorldDataPageState createState() => _WorldDataPageState();
}

class _WorldDataPageState extends State<WorldDataPage> {

  String _country = "USA";

  Future<CountryData> futureCountryData;

  _getCode(String country) {
    return DataSource.countryToCode[country];
  }

  @override
  void initState() {
    super.initState();
    futureCountryData = fetchCountryData();
    print(futureCountryData);
  }

  Future<CountryData> fetchCountryData() async {
    final response = await http.get('https://api.thevirustracker.com/free-api?countryTotal='+_getCode(_country));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);
      var countryData = jsonData["countrydata"][0];
      return new CountryData(infected: countryData["total_cases"], death:countryData["total_deaths"], recovered: countryData["total_recovered"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _updateCountry(String newCountry) {
    setState((){
      _country = newCountry;
    });
    futureCountryData = fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text("COVID-19 Tracker"),
          backgroundColor: Color.fromRGBO(132, 210, 230, 1.0),
        ),*/
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderSection(isWorld: true, countryCallBack: _updateCountry,),
              QuestionSection(),
              LatestUpdateSection(futureCountryData: futureCountryData),
              ActiveCases(),
            ],
          ),
        ),
    );
  }
}

class ActiveCases extends StatefulWidget {
  @override
  _ActiveCasesState createState() => _ActiveCasesState();
}

class _ActiveCasesState extends State<ActiveCases> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            "Active Cases",
            style: dropDownSelectedText,
          ),
        ),
      ],
    );
  }
}

