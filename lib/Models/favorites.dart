import 'package:fitx_flutter_2/Models/exercise.dart';
import 'package:hive/hive.dart';

part 'favorites.g.dart';

@HiveType(typeId: 5)
class Favorite {
  Favorite({String? name}) {
    _name = name;
  }
  @HiveField(0)
  String? _name = 'Favorite';
  @HiveField(1)
  List<Exercise> _favorites = [];
  get getName => _name;
  get getFavorites => _favorites;
  get getLength => _favorites.length;

  void setName(String? name) => _name = name;
  void addExercise(Exercise ex) => _favorites.add(ex);
  void deleteExercise(Exercise ex) => _favorites.remove(ex);
  Exercise getExerciseAt(int index) => _favorites[index];

  bool isNotEmpty() => _favorites.isNotEmpty;
  bool containsExercise(Exercise ex) => _favorites.contains(ex);
}
