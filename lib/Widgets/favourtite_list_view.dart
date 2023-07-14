import 'package:fitx_flutter_2/Providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/exercise.dart';
import '../constants.dart';
import 'custom_tiles.dart';
import 'message_box.dart';

class FavouriteListView extends StatelessWidget {
  const FavouriteListView({
    super.key,
    required Exercise excercise,
  }) : _excercise = excercise;

  final Exercise _excercise;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        return Container(
          decoration: kModalSheetDecoration,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            itemCount: workoutProvider.getFavoriteLength,
            itemBuilder: ((context, index) {
              return GestureDetector(
                child: CustomListTiles(
                  leading: 'Name: ${workoutProvider.getFavoriteName(index)}',
                  trailing: Text(''),
                  fav: workoutProvider.getFavoriteAt(index),
                ),
                onTap: () {
                  final fav = workoutProvider.getFavoriteAt(index);

                  if (!workoutProvider.containsExercise(fav, _excercise)) {
                    workoutProvider.updateFavourite(_excercise, index);
                    Navigator.pop(context);
                  } else {
                    showDialog<void>(
                      context: context,
                      builder: (context) =>
                          MessageBox('Folder already contains exercise.'),
                    );
                  }
                },
              );
            }),
          ),
        );
      },
    );
  }
}
