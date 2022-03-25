import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/screens/edit_good_habit_screen.dart';

class GoodHabitDetailsScreen extends StatefulWidget {
  static const routeName = '/good-habit-details-screen';

  final GoodHabitModel habitData;

  const GoodHabitDetailsScreen({Key? key, required this.habitData})
      : super(key: key);

  @override
  State<GoodHabitDetailsScreen> createState() =>
      _MyGoodHabitDetailScreenState();
}

class _MyGoodHabitDetailScreenState extends State<GoodHabitDetailsScreen> {
  String getScheduleFullName(String name) {
    if (name == 'fix') {
      return 'Fixed';
    } else if (name == 'fle') {
      return 'Flexible';
    } else {
      return 'Repeating';
    }
  }

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Habit',
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditGoodHabitScreen.routeName,
                arguments: widget.habitData,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * .02),
          Center(
            child: Text(widget.habitData.title),
          ),
          Padding(
            padding: EdgeInsets.all(size.height * .02),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(size.height * .025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Schedule Type'),
                        Text(getScheduleFullName(
                            widget.habitData.selectedScheduleType)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(size.height * .025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Start Date'),
                        Text(DateFormat.yMd()
                            .add_jm()
                            .format(widget.habitData.startDate)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .3,
            width: size.width * .9,
            child: const Text(
                'SuccessRateChart(chartData: _chartData, maxTimesDay: selectedHabit.timesDay)'),
          ),
        ],
      ),
    );
  }
}
