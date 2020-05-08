import 'package:flutter/material.dart';

class RegionModel with ChangeNotifier {
  String _region = "United States of America";

  String get region => _region;

  void setRegion(String newRegion) {
    _region = newRegion;
    notifyListeners();
  }
}