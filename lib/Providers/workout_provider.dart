import 'package:fitx_flutter_2/Models/favorites.dart';
import 'package:fitx_flutter_2/Providers/hive_db.dart';
import 'package:fitx_flutter_2/Screens/favourite_screen.dart';
import 'package:fitx_flutter_2/Screens/journal_page.dart';
import 'package:fitx_flutter_2/Screens/logs_screen.dart';
import 'package:fitx_flutter_2/Models/exercise.dart';
import 'package:fitx_flutter_2/Models/round.dart';
import 'package:fitx_flutter_2/Widgets/input_widget.dart';
import 'package:fitx_flutter_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'workout_provider.g.dart';

@HiveType(typeId: 2)
class WorkoutProvider extends ChangeNotifier {
  ////////////////// Variables //////////////////

  @HiveField(0)
  List<Exercise> _exercises = [];
  @HiveField(1)
  List<Favorite> _favorites = [];
  @HiveField(2)
  List<Round>? _queryWorkouts = [];
  @HiveField(5)
  List screens = [
    JournalPage(),
    LogsScreen(),
    FavouriteScreen(),
  ];
  @HiveField(6)
  int screenIndex = 0;

  ///////////////////// Setters and Getters //////////////////

  void toggleScreenIndex(int index) {
    screenIndex = index;
    notifyListeners();
  }

  void toggleRepsField(Round? set) {
    set!.toggleReps();
    notifyListeners();
  }

  void toggleWeightField(Round? set) {
    set!.toggleWeight();
    notifyListeners();
  }

  void setExerciseName(Exercise ex, String name) {
    ex.setName = name;
    notifyListeners();
  }

  void setRoundReps(Round? set, int value) {
    set!.reptitions = value;
    notifyListeners();
  }

  void setRoundWeight(Round? set, double value) {
    set!.weight = value;
    notifyListeners();
  }

  void getHiveExercises() async {
    final box = HiveDb();

    if (await box.isNotBoxEmpty()) {
      var list = await box.getValue(kPrefKey);
      if (list.isNotEmpty) {
        _exercises = list.cast<Exercise>();
      }
    }
    notifyListeners();
  }

  void setHiveExercises() {
    final box = HiveDb();
    if (_exercises.isNotEmpty) {
      for (Exercise ex in _exercises) {
        box.setValue(ex.getName, ex, kPrefKey);
      }
    }
  }

  // Set hive favourite exercises.

  void setHiveFavourites(String key, Favorite fav) async {
    final box = HiveDb();
    box.setValue(key, fav, kFavouritesPrefKey);
    await getFavourites();
    notifyListeners();
  }

  // Get hive favourite exercises.
  void getHiveFavourites(String fname) async {
    // final box = HiveDb();

    // var list = await box.getValue(kFavouritesPrefKey);

    if (await getFavourites()) {
      for (Favorite f in _favorites) {
        if (f.getName == fname) {
          _exercises.clear();
          _exercises.addAll(f.getFavorites);
          toggleScreenIndex(0);
        }
      }
    }
    notifyListeners();
  }

// Sets the favourites list from the hive query.
  Future<bool> getFavourites() async {
    final box = HiveDb();
    var list = await box.getValue(kFavouritesPrefKey);

    if (list.isNotEmpty) {
      _favorites = list.cast<Favorite>();
      notifyListeners();
      return true;
    }

    return false;
  }

  // Update hive favourite

  void updateFavourite(Exercise ex, int index) {
    final box = HiveDb();

    _favorites[index].addExercise(ex);

    box.updateValue(_favorites[index], kFavouritesPrefKey, index);

    notifyListeners();
  }

  // Check if favourites list contains exercise.

  bool containsExercise(Favorite fav, Exercise ex) => fav.containsExercise(ex);

  // Delete a favourite folder.

  void deleteFavouriteFolder(String key) async {
    final box = HiveDb();

    box.deleteValue(key, kFavouritesPrefKey);

    await getFavourites();

    notifyListeners();
  }

  // Delete exercise from favourite folder.

  void deleteExerciseFromFavourite(Exercise ex, Favorite fav) {
    fav.deleteExercise(ex);
    notifyListeners();
  }

  get getExercises => _exercises;
  get getFavorites => _favorites;
  get getExercisesLength => _exercises.length;
  get getQueryLength => _queryWorkouts!.length;
  get getFavoriteLength => _favorites.length;

  List<Round>? getQueryList() => _queryWorkouts;

  Exercise getExerciseAt(int index) => _exercises[index];
  Favorite getFavoriteAt(int index) => _favorites[index];
  String getFavoriteName(int index) => _favorites[index].getName;

  ////////////////// Main functions //////////////////

  void addExercise(Exercise excercise) {
    _exercises.add(excercise);
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    final box = HiveDb();

    box.deleteValue(exercise.getName, kPrefKey);
    _exercises.remove(exercise);
    notifyListeners();
  }

  void addSet(Exercise excercise) {
    excercise.addSet();
    notifyListeners();
  }

  void removeSet(Exercise excercise) {
    excercise.removeSet();
    notifyListeners();
  }

  List<InputWidget> getExerciseSets(Exercise excercise) =>
      excercise.getSetWidgets;
}
