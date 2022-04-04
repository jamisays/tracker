import 'package:flutter/material.dart';
import 'package:tracker/core/error/error_screen.dart';
import 'package:tracker/features/bad_habit/ui/screens/bad_habit_relapse_history_screen.dart';
import 'package:tracker/ui/screens/tabs_screen.dart';
// good habits
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/screens/edit_good_habit_screen.dart';
import 'package:tracker/features/good_habit/ui/screens/good_habit_details_screen.dart';
import 'package:tracker/features/good_habit/ui/screens/new_good_habit_screen.dart';

// bad habits
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/screens/new_bad_habit_screen.dart';
import 'package:tracker/features/bad_habit/ui/screens/edit_bad_habit_screen.dart';
import 'package:tracker/features/bad_habit/ui/screens/bad_habit_details_screen.dart';

const String initialRoute = '/';
const String newGoodHabit = '/new_good_habit';
const String goodHabitDetailScreen = '/good-habit-details-screen';
const String editGoodHabit = '/edit_good_habit';
const String newBadHabit = '/new_bad_habit';
const String badHabitDetailScreen = '/bad-habit-details-screen';
const String editBadHabit = '/edit_bad_habit';
const String badHabitRelapseHistory = '/bad_habit_relapse_history';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const TabsScreen());

      //! Good
      case newGoodHabit:
        return MaterialPageRoute(builder: (_) => const NewGoodHabitScreen());

      case goodHabitDetailScreen:
        final args = settings.arguments as GoodHabitModel;
        return MaterialPageRoute(
          builder: (_) => GoodHabitDetailsScreen(
            habitData: args,
          ),
        );

      case editGoodHabit:
        final args = settings.arguments as GoodHabitModel;
        return MaterialPageRoute(
          builder: (_) => EditGoodHabitScreen(
            habit: args,
          ),
        );

      //! Bad
      case newBadHabit:
        return MaterialPageRoute(builder: (_) => const NewBadHabitScreen());

      case badHabitDetailScreen:
        final args = settings.arguments as BadHabitModel;
        return MaterialPageRoute(
          builder: (_) => BadHabitDetailsScreen(
            habitData: args,
          ),
        );

      case editBadHabit:
        final args = settings.arguments as BadHabitModel;
        return MaterialPageRoute(
          builder: (_) => EditBadHabitScreen(
            habit: args,
          ),
        );

      case badHabitRelapseHistory:
        final args = settings.arguments as BadHabitModel;
        return MaterialPageRoute(
          builder: (_) => BadHabitRelapseHistoryScreen(
            habit: args,
          ),
        );

      //! Default
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
            message: 'Route Error',
          ),
        );
    }
  }
}
