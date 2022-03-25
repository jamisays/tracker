import 'package:flutter/material.dart';
import 'package:tracker/core/error/error_screen.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/screens/edit_good_habit_screen.dart';
import 'package:tracker/features/good_habit/ui/screens/good_habit_details_screen.dart';
import 'package:tracker/features/good_habit/ui/screens/new_good_habit_screen.dart';
import 'package:tracker/ui/screens/tabs_screen.dart';

const String initialRoute = '/';
const String newGoodHabit = '/new_good_habit';
const String goodHabitDetailScreen = '/good-habit-details-screen';
const String editGoodHabit = '/edit_good_habit';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const TabsScreen());

      case newGoodHabit:
        return MaterialPageRoute(builder: (_) => const NewGoodHabitScreen());

      case goodHabitDetailScreen:
        final args = settings.arguments as GoodHabitModel;
        return MaterialPageRoute(
            builder: (_) => GoodHabitDetailsScreen(
                  habitData: args,
                ));

      case editGoodHabit:
        final args = settings.arguments as GoodHabitModel;
        return MaterialPageRoute(
            builder: (_) => EditGoodHabitScreen(
                  habit: args,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
            message: 'Route Error',
          ),
        );
    }
  }
}
