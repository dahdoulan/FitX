import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 6)
class WorkoutUser {
  @HiveField(0)
  String _email = '';
  @HiveField(1)
  String _password = '';

  set setEmail(value) => _email = value;
  set setPassword(value) => _password = value;

  get getEmail => _email;
  get getPassword => _password;
}
