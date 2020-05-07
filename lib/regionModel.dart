import 'package:flutter/material.dart';

class RegionModel with ChangeNotifier {
  String region = "United States of America";

  void setRegion(String newRegion) {
    region = newRegion;
    notifyListeners();
  }
}