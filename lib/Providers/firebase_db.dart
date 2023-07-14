import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitx_flutter_2/Widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/exercise.dart';
import '../Models/round.dart';

class FirebaseHandler extends ChangeNotifier {
  Future saveExercises(
      BuildContext context, List<Exercise> exercises, String email) async {
    final dateNow = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateNow);

    if (exercises.isEmpty) {
      showDialog<void>(
        context: context,
        builder: (context) => MessageBox('No exercises found.'),
      );
    } else {
      for (Exercise ex in exercises) {
        if (ex.getName == "Excercise name") {
          showDialog<void>(
            context: context,
            builder: (context) => MessageBox('Please enter an exercise name.'),
          );
          break;
        } else if (ex.setsisEmpty) {
          showDialog<void>(
            context: context,
            builder: (context) => MessageBox('One or more exercises are empty'),
          );
        } else {
          try {
            for (Round set in ex.getSets) {
              if (set.reptitions != 0 && set.weight >= 0) {
                Map<String, dynamic> data = {
                  'Reps': set.reptitions,
                  'Sets': set.setNumber,
                  'Weight': set.weight
                };

                var query = await FirebaseFirestore.instance
                    .collection('User')
                    .doc(email)
                    .collection('Exercises')
                    .doc(ex.getName)
                    .collection('Logs')
                    .doc(DateTime.now().toString())
                    .set(data);

                showDialog<void>(
                  context: context,
                  builder: (context) =>
                      MessageBox('Uploaded data successfuly !'),
                );
              } else {
                showDialog<void>(
                  context: context,
                  builder: (context) =>
                      MessageBox('Please enter a valid input.'),
                );

                break;
              }
            }
          } catch (ex) {
            showDialog<void>(
              context: context,
              builder: (context) =>
                  MessageBox('Error saving data, please try again'),
            );
          }
        }
      }
    }
  }

  Future readSets(
      {String? exercise = 'Bench Press',
      required BuildContext context,
      required List<Round>? queryWorkouts,
      required String email}) async {
    queryWorkouts!.clear();
    await FirebaseFirestore.instance
        .collection('User')
        .doc(email)
        .collection('Exercises')
        .doc(exercise)
        .collection('Logs')
        .get()
        .then(
          (snapshot) => {
            if (snapshot.docs.isNotEmpty)
              {
                snapshot.docs.forEach((doc) {
                  if (doc.data().isNotEmpty) {
                    // Converting each query to a set (Round object) and adding it the query list to then display in the graph.
                    queryWorkouts.add(Round.fromJson(doc.data()));
                  }
                }),
              }
            else
              {
                showDialog<void>(
                  context: context,
                  builder: (context) =>
                      MessageBox('No logs found for ${exercise}'),
                )
              }
          },
        );

    notifyListeners();
  }
}
