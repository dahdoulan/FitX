import 'package:fitx_flutter_2/Models/round.dart';
import 'package:fitx_flutter_2/Widgets/input_widget.dart';
import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 2)
class Exercise {
  @HiveField(0)
  String _name = "Excercise name";
  @HiveField(1)
  int _setNumber = 1;

  @HiveField(2)
  List<Round> _sets = [];

  @HiveField(3)
  List<InputWidget> _setWidgets = [];

  set setName(name) => _name = name;
  set setRounds(rounds) => _sets = rounds;

  get getName => _name;

  get getSetNumber => _setNumber;

  get getSetsLength => _sets.length;

  get setWidgets => _setWidgets;

  get getSetWidgets => _setWidgets;

  get getSets => _sets;

  get setsisEmpty => _sets.isEmpty;

  void addSet() {
    Round set = Round(setNumber: _setNumber++);
    _sets.add(set);

    _setWidgets.add(InputWidget(
      set: set,
    ));
  }

  void clearLists() {
    _setWidgets.clear();
    _sets.clear();
  }

  void removeSet() {
    if (!_sets.isEmpty) {
      _sets.removeLast();
      _setNumber--;
    }
    if (!_setWidgets.isEmpty) _setWidgets.removeLast();
  }
}
