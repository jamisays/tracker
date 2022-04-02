// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tracker/core/hive_service.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/ui/logic/timer_stream/timer_stream_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoodHabitCubit>(
          create: (_) => injection<GoodHabitCubit>(),
        ),
        BlocProvider<BadHabitCubit>(
          create: (_) => injection<BadHabitCubit>(),
        ),
        BlocProvider<TimerStreamCubit>(
          create: (_) => injection<TimerStreamCubit>(),
        ),
      ],
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
