import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitx_flutter_2/Utils/empty_exercise.dart';
import 'package:fitx_flutter_2/Utils/empty_exercise_name.dart';
import 'package:fitx_flutter_2/Utils/no_logs_found.dart';
import 'package:fitx_flutter_2/Widgets/message_box.dart';
import 'package:flutter/material.dart';

import '../Models/exercise.dart';
import '../Models/round.dart';

class FirebaseHandler extends ChangeNotifier {
  Future<void> saveExercises(List<Exercise> exercises, String email) async {
    if (exercises.isEmpty) {
      throw EmptyExerciseException();
    } else {
      for (Exercise ex in exercises) {
        if (ex.getName == "Excercise name") {
          throw (EmptyExerciseNameException());
        } else if (ex.setsisEmpty) {
          throw (EmptyExerciseException());
        } else {
          for (Round set in ex.getSets) {
            if (set.reptitions != 0 && set.weight >= 0) {
              Map<String, dynamic> data = {
                'Reps': set.reptitions,
                'Sets': set.setNumber,
                'Weight': set.weight
              };

              await FirebaseFirestore.instance
                  .collection('User')
                  .doc(email)
                  .collection('Exercises')
                  .doc(ex.getName)
                  .collection('Logs')
                  .doc(DateTime.now().toString())
                  .set(data);
            } else {
              throw (Exception('Error adding data to database.'));
            }
          }
        }
      }
    }
  }

  Future readSets({
    String? exercise = 'Bench Press',
    required List<Round>? queryWorkouts,
    required String email,
  }) async {
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
                    queryWorkouts.add(
                      Round.fromJson(
                        doc.data(),
                      ),
                    );
                  }
                }),
              }
            else
              {throw (NoLogsFoundException())}
          },
        );

    notifyListeners();
  }
}
