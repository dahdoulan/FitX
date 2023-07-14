import 'package:fitx_flutter_2/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDb extends ChangeNotifier {
  Future<void> setValue(String key, Object set, String prefKey) async {
    final box = Hive.box(prefKey);
    return box.put(key, set);
  }

  Future<List<dynamic>> getValue(String prefKey) async {
    final box = Hive.box(prefKey);

    return box.isNotEmpty ? box.values.toList() : [];
  }

  Future<bool> isNotBoxEmpty() async {
    final box = Hive.box(kPrefKey);

    return box.isNotEmpty;
  }

  void updateValue(Object obj, String prefKey, int index) async {
    final box = Hive.box(prefKey);

    box.putAt(index, obj);
  }

  void deleteValue(String key, String prefKey) async {
    final box = Hive.box(prefKey);

    box.delete(key);
  }
}
