import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';

Future<void> initializeHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GoodHabitModelAdapter());
  Hive.registerAdapter(BadHabitModelAdapter());
}
