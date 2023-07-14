import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:flutter/material.dart';

import 'package:fitx_flutter_2/Models/round.dart';

import 'package:fitx_flutter_2/constants.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';

part 'input_widget.g.dart';

@HiveType(typeId: 4)
class InputWidget extends StatefulWidget {
  InputWidget({this.set});
  @HiveField(0)
  Round? set;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @HiveField(1)
  final List<TextEditingController> _controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) => Container(
        width: 350.0,
        height: 27.0,
        child: Row(
          //This Row widget is for the text fields.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text(
                "${widget.set?.setNumber}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kYellow,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: widget.set!.repsCheck
                  ? GestureDetector(
                      child: Text(
                        '${widget.set!.reptitions} Reps',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kYellow,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        workoutProvider.toggleRepsField(widget.set);
                      },
                    )
                  : TextField(
                      cursorHeight: 17.0,
                      textAlign: TextAlign.center,
                      cursorColor: kYellow,
                      style: TextStyle(color: kYellow),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: kYellow,
                        label: Center(
                          child: Text(
                            "Reps",
                            style: TextStyle(
                              color: kYellow,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      controller: _controllers[1],
                      onChanged: (value) => value != ""
                          ? workoutProvider.setRoundReps(
                              widget.set, int.parse(value))
                          : null,
                      onTapOutside: (event) {
                        workoutProvider.toggleRepsField(widget.set);
                      },
                      // autofocus: true,
                    ),
            ),
            Expanded(
              child: widget.set!.weightCheck
                  ? GestureDetector(
                      child: Text(
                        '${widget.set!.weight} Kg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kYellow,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        workoutProvider.toggleWeightField(widget.set);
                      },
                    )
                  : TextField(
                      cursorHeight: 17.0,
                      textAlign: TextAlign.center,
                      cursorColor: kYellow,
                      style: TextStyle(color: kYellow),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Center(
                          child: Text(
                            "Weight",
                            style: TextStyle(
                              color: kYellow,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      controller: _controllers[2],
                      onChanged: (value) => value != ""
                          ? workoutProvider.setRoundWeight(
                              widget.set, double.parse(value))
                          : null,
                      onTapOutside: (event) {
                        workoutProvider.toggleWeightField(widget.set);
                      },
                      // autofocus: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
