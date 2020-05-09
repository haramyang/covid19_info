import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid19_info/dataSource.dart';

class HeaderSection extends StatefulWidget {
  HeaderSection({Key key, this.isWorld, this.countryCallBack}) : super(key: key);
  final bool isWorld;
  final ValueChanged<String> countryCallBack;

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection>{

  String _selectedVal = 'USA';
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