import 'package:hive/hive.dart';

part 'round.g.dart';

@HiveType(typeId: 3)
class Round {
  @HiveField(0)
  int setNumber;
  @HiveField(1)
  int reptitions;
  @HiveField(2)
  double weight;

  bool repsCheck = true;
  bool weightCheck = true;

  Round({this.reptitions = 0, this.weight = 0.0, this.setNumber = 0});

  void toggleReps() => repsCheck = !repsCheck;
  void toggleWeight() => weightCheck = !weightCheck;

  Map<String, dynamic> toJson() => {
        'sets': setNumber,
        'reps': reptitions,
        'weight': weight,
      };

  static Round fromJson(Map<String, dynamic> json) => Round(
        setNumber: json['Sets'],
        weight: json['Weight'],
        reptitions: json['Reps'],
      );
}
