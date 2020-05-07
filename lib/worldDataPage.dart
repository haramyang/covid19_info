import 'package:flutter/material.dart';
import 'package:covid19_info/dataSource.dart';

class WorldDataPage extends StatefulWidget {
  @override
  _WorldDataPageState createState() => _WorldDataPageState();
}

class _WorldDataPageState extends State<WorldDataPage> {
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
}

class HeaderSection extends StatefulWidget {
  HeaderSection({Key key, this.isWorld}) : super(key: key);
  final bool isWorld;

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection>{

  String _selectedVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            (widget.isWorld ? "World " : "US ") + "Current Outbreak",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: double.infinity,
          height: 200.0,
          child: DropdownButton<String>(
            hint: Text("Select a country", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black)),
            isExpanded: true,
            value: _selectedVal,
            selectedItemBuilder: (BuildContext context) {
              return DataSource.countries.map<Widget>((String country) {
                return Text(country, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black));
              }).toList();
            },
            items: DataSource.countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.grey)),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _selectedVal = newVal;
              });
            },
          ),
        ),
      ],
    );
  }
}