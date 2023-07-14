import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:fitx_flutter_2/Widgets/excercise_tile.dart';

import 'package:flutter/material.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:provider/provider.dart';

class MainListCard extends StatelessWidget {
  // Excercise? excercise;
  // MainListCard({required this.excercise});
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        return Container(
          //This container is the main journal background card.
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            itemCount: workoutProvider.getExercisesLength,
            itemBuilder: ((context, index) {
              return ExcerciseTile(workoutProvider.getExerciseAt(index));
            }),
          ),

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                //Gives the background of the card a shadow effect.
                color: kBlack,
                blurRadius: 5.0,
                spreadRadius: 2.0,
              )
            ],
            color: kMoove,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        );
      },
    );
  }
}
