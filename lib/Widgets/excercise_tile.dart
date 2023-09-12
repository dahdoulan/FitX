import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:fitx_flutter_2/Providers/exercise_names.dart';
import 'package:flutter/material.dart';
import 'package:fitx_flutter_2/Models/exercise.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'favourtite_list_view.dart';

class ExcerciseTile extends StatelessWidget {
  ExcerciseTile(Exercise excercise) {
    _excercise = excercise;
  }
  Exercise _excercise = Exercise();

  @override
  Widget build(BuildContext context) {
    return Consumer2<WorkoutProvider, ExerciseNames>(
      builder: (context, workoutProvider, workouts, child) {
        return Padding(
          padding: EdgeInsets.only(left: 27.0, top: 17.0),
          child: Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      workoutProvider.removeExercise(_excercise),
                  backgroundColor: kMoove,
                  icon: Icons.delete_outline,
                  foregroundColor: kYellow,
                ),
                SlidableAction(
                  onPressed: (context) {
                    showModalBottomSheet(
                      context: context,
                      shape: kRoundedRectangle,
                      builder: (context) {
                        return FavouriteListView(excercise: _excercise);
                      },
                    );
                  },
                  backgroundColor: kMoove,
                  icon: Icons.favorite_border,
                  foregroundColor: kYellow,
                )
              ],
            ),
            child: Container(
              width: 350.0,
              //This is the tiles container.
              decoration: BoxDecoration(
                boxShadow: [kBoxShadow3],
                color: kMoove,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                //This column is to format the title and the text fields for the input.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 50.0),
                    width: double.infinity,
                    child: Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          titleMedium: TextStyle(color: kYellow),
                        ),
                      ),
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          searchFieldProps: TextFieldProps(
                            cursorColor: kYellow,
                            decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle: kInputTextStyle),
                            style: TextStyle(color: kYellow),
                          ),
                          showSearchBox: true,
                          showSelectedItems: true,
                          modalBottomSheetProps: ModalBottomSheetProps(
                            backgroundColor: kMoove,
                          ),
                        ),
                        dropdownButtonProps:
                            DropdownButtonProps(color: kYellow),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          textAlign: TextAlign.center,
                          baseStyle: kInputTextStyle,
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '${_excercise.getName}',
                            hintStyle: kInputTextStyle,
                          ),
                        ),
                        onChanged: (exerciseName) => workoutProvider
                            .setExerciseName(_excercise, exerciseName!),
                        items: workouts.getWorkouts,
                      ),
                    ),
                  ),
                  Wrap(
                    //A wrapper for the exercise sets in each workout.
                    children: workoutProvider.getExerciseSets(_excercise),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        //Add set button.
                        onPressed: () {
                          //Adds a set to a set list in an exercise.
                          workoutProvider.addSet(_excercise);
                        },
                        child: Container(
                          child: Icon(
                            Icons.add,
                            color: kMoove,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [kBoxShadow2],
                            color: kYellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      TextButton(
                        //Add set button.
                        onPressed: () {
                          //Adds a set to a set list in an exercise.

                          workoutProvider.removeSet(_excercise);
                        },
                        child: Container(
                          child: Icon(
                            Icons.remove,
                            color: kMoove,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [kBoxShadow2],
                            color: kCyan,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
