import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Models/round.dart';

class ChartProvider extends ChangeNotifier {
  List<FlSpot> _spots = [];
  bool showMe = false;

  List<FlSpot> getSpots() => _spots;

  void toggleShowMe() {
    showMe = true;
    notifyListeners();
  }

  void readFlSpots(List<Round>? queryWorkouts) {
    if (queryWorkouts!.isNotEmpty) {
      //Work-around for the mostLeftSpot error.
      _spots.clear();
    }

    double count = 1;
    for (var set in queryWorkouts) {
      //Adding each query of sets to as a dot on the graph.
      print(set.weight);
      _spots.add(FlSpot(count++, set.weight));
      toggleShowMe();
    }

    notifyListeners();
  }
}
