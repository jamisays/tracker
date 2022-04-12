import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/ui/logic/timer_stream/timer_stream_cubit.dart';
import 'package:tracker/features/bad_habit/ui/widgets/bad_habit_timer.dart';
import 'package:tracker/features/bad_habit/ui/widgets/record_card.dart';
import 'package:tracker/features/bad_habit/ui/widgets/relapse_reason_dialog.dart';
import 'package:tracker/utils/bad_habit_utils.dart';

class BadHabitDetailsScreen extends StatefulWidget {
  static const routeName = '/bad-habit-details-screen';
  final BadHabitModel habitData;

  const BadHabitDetailsScreen({Key? key, required this.habitData})
      : super(key: key);

  @override
  State<BadHabitDetailsScreen> createState() => _BadHabitDetailsScreenState();
}

class _BadHabitDetailsScreenState extends State<BadHabitDetailsScreen> {
  // late StopWatchTimer stopwatchStream;

  Map<DateTime, int>? heatMap = {};

  @override
  void initState() {
    super.initState();
    dispatchGetStopwatchStream();
    heatMap = setHeatMap(widget.habitData);
  }

  @override
  void dispose() async {
    super.dispose();
    // dispatchDisposeStopwatchStream(widget.habitData.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(stopwatchStream.isRunning);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habitData.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Edit'),
                value: '/edit_bad_habit',
              ),
              const PopupMenuItem(
                child: Text('History'),
                value: '/bad_habit_relapse_history',
              ),
            ],
            onSelected: (value) {
              Navigator.of(context).pushNamed(
                value.toString(),
                arguments: widget.habitData,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BadHabitTimer(),
            SizedBox(
              height: size.height * .365,
              width: size.width * .95,
              child: GridView(
                children: const [
                  RecordCard(100, 'Best Streak', Icons.thumb_up_alt),
                  RecordCard(80, 'Current Streak', Icons.calendar_today),
                  RecordCard(1, 'Relapses', Icons.add_chart_outlined),
                  RecordCard(80, 'Current Streak', Icons.add_chart_outlined),
                ],
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .55,
              width: size.width * .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * .04),
                    child: Text(
                      'Heatmap Calendar',
                      style: TextStyle(fontSize: size.width * .05),
                    ),
                  ),
                  HeatMapCalendar(
                    datasets: heatMap,
                    colorMode: ColorMode.color,
                    size: size.width * .1,
                    borderRadius: size.height * .003,
                    defaultColor: Colors.grey,
                    showColorTip: false,
                    textColor: Colors.white,
                    colorsets: const {
                      1: Colors.red,
                      7: Colors.green,
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Reset'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red.shade400),
              ),
              onPressed: () {
                var badRelapseTime = DateTime.now();
                ShowAlertDialog(context)
                    .showBadHabitRelapseReasonDialog(context)
                    .then((value) {
                  dispatchBadHabitRelapsed(
                      widget.habitData.id, badRelapseTime, value);
                  // Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  dispatchGetStopwatchStream() {
    BlocProvider.of<TimerStreamCubit>(context)
        .cGetStopwatchStreamValue(widget.habitData.id);
  }

  dispatchDisposeStopwatchStream(String id) {
    BlocProvider.of<TimerStreamCubit>(context).cDisposeBadItemStream(id);
  }

  dispatchBadHabitRelapsed(String key, DateTime time, String? reason) {
    BlocProvider.of<BadHabitCubit>(context)
        .cBadHabitRelapsed(key, time, reason);
  }
}
