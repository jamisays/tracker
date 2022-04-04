import 'package:flutter/material.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

//! Details Screen Helper Methods: Heatmap Utils === START

Map<DateTime, int>? setHeatMap(BadHabitModel habit) {
  Map<DateTime, int>? map;
  var length = DateTime.now().difference(habit.createDate).inDays;

  int j = 0;
  var jLength = habit.relapsedDaysList!.length;
  for (int i = 0; i <= length; i++) {
    var date = habit.createDate.add(Duration(days: i));
    bool perfectDay = true;

    date = removeTime(date);
    if (habit.relapsedDaysList!.isNotEmpty) {
      if (j < jLength) {
        if (removeTime(habit.relapsedDaysList![j]) == date) {
          map?[date] = 1;
          perfectDay = false;
          j = findNextDayIndex(j, habit);
        }
      }
    }
    if (perfectDay) map?[date] = 7;
  }

  return map;
}

DateTime removeTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

int findNextDayIndex(int x, BadHabitModel habit) {
  if (x == habit.relapsedDaysList!.length - 1) return x;
  if (x < habit.relapsedDaysList!.length) {
    while (
        habit.relapsedDaysList![x].day == habit.relapsedDaysList![x + 1].day) {
      x++;
      if (x == habit.relapsedDaysList!.length - 1) return x;
    }
  }
  x++;
  return x;
}

//* Heatmap Utils === END

//! Form utils === START

const difficultyMenuItems = <String>[
  'Easy',
  'Medium',
  'Hard',
];

final List<DropdownMenuItem<String>> difficultyDropdownMenuItems =
    difficultyMenuItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

const frequencyTypeItems = <String>[
  'Daily',
  'Weekly',
  'Monthly',
];

final List<DropdownMenuItem<String>> frequencyTypeItemsDropdownMenuItems =
    frequencyTypeItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);

final enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);

//* Form utils === END
