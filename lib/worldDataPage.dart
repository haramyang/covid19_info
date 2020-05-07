import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:covid19_info/regionModel.dart';

const TextStyle regularText =  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);
const TextStyle dropDownSelectedText = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black);
const TextStyle dropDownItemText = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black87);

class WorldDataPage extends StatefulWidget {
  @override
  _WorldDataPageState createState() => _WorldDataPageState();
}

class _WorldDataPageState extends State<WorldDataPage> {

  //TODO: Figure out how to use Consumer to send API call with the RegionModel
  //Consumer<RegionModel>(builder: (context, reg, child) => Text(reg.region)),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0),
          child: Column(
            children: <Widget>[
              HeaderSection(isWorld: true),
            ],
          ),
        ),
    );
  }

  Widget questionSection() {
    return Container(
      child:
    );
  }
}

class HeaderSection extends StatefulWidget {
  HeaderSection({Key key, this.isWorld}) : super(key: key);
  final bool isWorld;

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
              Provider.of<RegionModel>(context, listen: false).setRegion(newVal);
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