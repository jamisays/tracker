// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';
import 'package:tracker/routes.dart';
import 'package:tracker/ui/screens/tabs_screen.dart';
import 'package:tracker/injection_container.dart';

void main() async {
  await initializeHive();
  initializeInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injection<GoodHabitCubit>(),
      child: MaterialApp(
        title: 'Habit Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My Habits'),
          ),
          body: TabsScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future<void> initializeHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GoodHabitModelAdapter());
}
