import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

class RelapseItem extends StatelessWidget {
  // const RelapseItem({Key? key}) : super(key: key);
  final int index;
  final BadHabitModel habit;
  // final time;

  Widget get getDuration {
    // if index is zero, returns date difference from create date to first index
    // date, that means first relapse date, else return difference from
    // previous index to next index relapse date
    return Text(index > 0
        ? DateFormat.yMd().add_jm().format(habit.relapsedDaysList![index - 1]) +
            ' - ' +
            DateFormat.yMd().add_jm().format(habit.relapsedDaysList![index])
        : DateFormat.yMd().add_jm().format(habit.createDate) +
            ' - ' +
            DateFormat.yMd().add_jm().format(habit.relapsedDaysList![index]));
  }

  Widget get getStreak {
    return Text((index > 0
            ? habit.relapsedDaysList![index]
                .difference(habit.relapsedDaysList![index - 1])
            : habit.relapsedDaysList![index].difference(habit.createDate))
        .toString());
  }

  const RelapseItem(this.index, this.habit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: getDuration,
      trailing: getStreak,
      subtitle: Text(
          habit.relapsedReasons![habit.relapsedDaysList![index]].toString()),
    );
  }
}
