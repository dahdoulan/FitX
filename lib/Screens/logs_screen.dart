import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitx_flutter_2/Providers/chart_provider.dart';
import 'package:fitx_flutter_2/Providers/firebase_db.dart';
import 'package:fitx_flutter_2/Providers/user_provider.dart';

import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:fitx_flutter_2/Providers/exercise_names.dart';
import 'package:fitx_flutter_2/Widgets/message_box.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Widgets/custom_tiles.dart';

class LogsScreen extends StatelessWidget {
  String? _selectedWorkout = "Bench Press";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMoove,
      body: SafeArea(
        child: Consumer5<WorkoutProvider, ExerciseNames, ChartProvider,
            FirebaseHandler, UserProvider>(
          builder:
              (context, workoutProvider, workouts, chart, db, user, child) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 40.0),
                  width: 300.0,
                  decoration:
                      BoxDecoration(boxShadow: [kBoxShadow], color: kMoove),
                  child: Theme(
                    data: ThemeData(
                      textTheme: TextTheme(
                        titleMedium: TextStyle(color: kYellow),
                      ),
                    ),
                    child: DropdownSearch<String>(
                      dropdownButtonProps: DropdownButtonProps(
                        color: kYellow,
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        textAlign: TextAlign.center,
                        baseStyle: kInputTextStyle,
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select an exercise',
                          hintStyle: kInputTextStyle,
                        ),
                      ),
                      popupProps: PopupProps.modalBottomSheet(
                        searchFieldProps: TextFieldProps(
                          cursorColor: kYellow,
                          decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: kInputTextStyle),
                          style: TextStyle(color: kYellow),
                        ),
                        modalBottomSheetProps: ModalBottomSheetProps(
                          backgroundColor: kMoove,
                          elevation: 10.0,
                        ),
                        showSearchBox: true,
                      ),
                      onChanged: (value) async {
                        try {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: CircularProgressIndicator(
                                color: kYellow,
                              ),
                            ),
                          );
                          _selectedWorkout = value;
                          await db.readSets(
                            exercise: _selectedWorkout,
                            email: user.getEmail,
                            queryWorkouts: workoutProvider.getQueryList(),
                          );

                          chart.readFlSpots(workoutProvider.getQueryList());
                          Navigator.pop(context);
                        } catch (ex) {
                          showDialog<void>(
                            context: context,
                            builder: (context) => MessageBox(
                              ex.toString(),
                            ),
                          );
                        }
                      },
                      items: workouts.getWorkouts,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        border: Border.all(
                          color: kYellow,
                          width: 1.0,
                        ),
                      ),
                      gridData: FlGridData(
                        getDrawingHorizontalLine: (value) =>
                            FlLine(color: kYellow, strokeWidth: 1.0),
                        getDrawingVerticalLine: (value) =>
                            FlLine(color: kYellow, strokeWidth: 1.0),
                      ),
                      backgroundColor: kMoove,
                      titlesData: FlTitlesData(
                        show: false,
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          color: kYellow,
                          show: chart.showMe,
                          spots: chart.getSpots(),
                        )
                      ],
                    ),
                  ),
                  width: double.infinity,
                  height: 210.0,
                  decoration: BoxDecoration(
                    boxShadow: [kBoxShadow3],
                    color: kMoove,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        boxShadow: [kCardShadow],
                        color: kMoove,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomListTiles(
                            leading:
                                'Reps: ${workoutProvider.getQueryList()![index].reptitions}',
                            trailing: Text(
                              'Weight: ${workoutProvider.getQueryList()![index].weight}',
                              style: TextStyle(color: kMoove),
                            ));
                      },
                      itemCount: workoutProvider.getQueryLength,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
