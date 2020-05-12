import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:covid19_info/headerSection.dart';
import 'package:covid19_info/latestUpdate.dart';
import 'package:covid19_info/countryData.dart';
import 'package:covid19_info/questionSection.dart';
import 'package:covid19_info/apiHandler.dart';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;


class ChartData {
  int month;
  int day;
  int year;
  int count;

  ChartData(this.month, this.day, this.year, this.count);
}

class TimeSeriesCount {
  final DateTime time;
  final int count;
  final charts.Color barColor;

  TimeSeriesCount({this.time, this.count, this.barColor});
}

class WorldDataPage extends StatefulWidget {
  @override
  _WorldDataPageState createState() => _WorldDataPageState();
}

class _WorldDataPageState extends State<WorldDataPage> {

  String _country = "USA";

  Future<CountryData> futureCountryData;
  Future<List<TimeSeriesCount>> futureCountryCountData;
  List<ChartData> chartData = [];

  _getCode(String country) {
    return DataSource.countryToCode[country];
  }

  _formatChartData(var data) {
    data.remove("stat");
    data.forEach((k,v) {
      List<String> dates = k.split('/');
      int count = v["new_daily_cases"];
      ChartData c = new ChartData(int.parse(dates[0]), int.parse(dates[1]), 2020, count);
      chartData.add(c);
    });
  }

  _getLast20Dates(List<ChartData> data) {
    final List<TimeSeriesCount> seriesList = [];
    for(int i = data.length-20; i < data.length; ++i) {
      ChartData c = data[i];
      print("${c.month}/${c.day}");
      seriesList.add(TimeSeriesCount(
        time: new DateTime(c.year, c.month, c.day),
        count: c.count,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ));
    }

    return seriesList;
  }

  @override
  void initState() {
    super.initState();
    futureCountryData = fetchCountryData();
    futureCountryCountData = fetchCountryCountData();
  }

  Future<List<TimeSeriesCount>> fetchCountryCountData() async {
    final response = await API.getData('countryTimeline=' + _getCode(_country));

    var jsonData = json.decode(response.body);
    var countryData = jsonData["timelineitems"][0];
    _formatChartData(countryData);
    return _getLast20Dates(chartData);

  }

  Future<CountryData> fetchCountryData() async {

    final response = await API.getData('countryTotal=' + _getCode(_country));
    var jsonData = json.decode(response.body);
    var countryData = jsonData["countrydata"][0];
    return new CountryData(infected: countryData["total_cases"], death:countryData["total_deaths"], recovered: countryData["total_recovered"]);
  }

  _updateCountry(String newCountry) {
    setState((){
      _country = newCountry;
    });
    futureCountryData = fetchCountryData();
    futureCountryCountData = fetchCountryCountData();
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
              ActiveCases(data: futureCountryCountData),
            ],
          ),
        ),
    );
  }
}

class ActiveCases extends StatefulWidget {

  ActiveCases({this.data});
  final Future<List<TimeSeriesCount>> data;

  @override
  _ActiveCasesState createState() => _ActiveCasesState();
}

class _ActiveCasesState extends State<ActiveCases> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            "Active Cases",
            style: dropDownSelectedText,
          ),
        ),
        Container(child: CoronaCountChart(futureCountryCountData: widget.data),),
      ],
    );
  }
}


class CoronaCountChart extends StatelessWidget {
  Future<List<TimeSeriesCount>> futureCountryCountData;

  CoronaCountChart({this.futureCountryCountData});

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 250,
      padding: EdgeInsets.only(top: 5.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
                "New cases vs Last 20 days",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                ),
            ),
            FutureBuilder(
              future: futureCountryCountData,
              builder: (context, snapshot) {
                List<charts.Series<TimeSeriesCount, DateTime>> series
                = [
                  charts.Series(
                    id: "Corona Count",
                    data: snapshot.data,
                    domainFn: (TimeSeriesCount series, _) => series.time,
                    measureFn: (TimeSeriesCount series, _) => series.count,
                    colorFn: (TimeSeriesCount series, _) => series.barColor,
                  )
                ];

                if (snapshot.hasData) {
                  return Expanded(
                    child: charts.TimeSeriesChart(
                      series,
                      animate: true,
                      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                      defaultInteractions: false,
                      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}


