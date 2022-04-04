import 'package:flutter/material.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/widgets/relapse_item.dart';

class BadHabitRelapseHistoryScreen extends StatefulWidget {
  const BadHabitRelapseHistoryScreen({Key? key, required this.habit})
      : super(key: key);
  static const routeName = '/bad_habit_relapse_history';
  final BadHabitModel habit;

  @override
  _RelapseHistoryState createState() => _RelapseHistoryState();
}

class _RelapseHistoryState extends State<BadHabitRelapseHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relapse History'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.habit.relapsedDaysList!.length,
            reverse: true,
            itemBuilder: (context, index) {
              return RelapseItem(
                index,
                widget.habit,
              );
            },
          ),
        ),
      ),
    );
  }
}
