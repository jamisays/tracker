import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/ui/logic/timer_stream/timer_stream_cubit.dart';
import 'package:tracker/features/bad_habit/ui/screens/bad_habit_details_screen.dart';

class BadHabitItem extends StatefulWidget {
  const BadHabitItem({Key? key, required this.badHabit}) : super(key: key);

  final BadHabitModel badHabit;

  @override
  _BadHabitItemState createState() => _BadHabitItemState();
}

void selectBadHabit(BuildContext context, BadHabitModel badHabit) {
  Navigator.of(context).pushNamed(
    BadHabitDetailsScreen.routeName,
    arguments: badHabit,
  );
}

class _BadHabitItemState extends State<BadHabitItem> {
  // for measuring progress of today for today's progress bar
  late int _todaySeconds;
  void setTodaySeconds(var todaySeconds) {
    _todaySeconds = todaySeconds;
  }

  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    if (!_stopWatchTimer.isRunning) {
      var days = DateTime.now().difference(widget.badHabit.createDate).inDays;
      var seconds =
          DateTime.now().difference(widget.badHabit.createDate).inSeconds;
      _stopWatchTimer.setPresetSecondTime(seconds);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      var todaySeconds = seconds - (days * 86400);
      setTodaySeconds(todaySeconds);
      // ----------------- need to optimize ----------------
      // _stopWatchTimer.minuteTime.listen((value) {
      //   setTodaySeconds(value * 60);
      //   // print('secondTime $value');
      // });
      // ----------------- need to optimize ----------------
    }

    dispatchSetBadHabitItemStreamValue(widget.badHabit.id, _stopWatchTimer);

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    // disposeDisposeBadHabitItemStream(widget.badHabit.id);
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => selectBadHabit(context, widget.badHabit),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(
            horizontal: size.height * .01, vertical: size.height * .01),
        child: ListTile(
          // tileColor: Color.fromRGBO(224, 221, 170, 1),
          tileColor: Theme.of(context).listTileTheme.tileColor,
          leading: CircularPercentIndicator(
            radius: size.height * .043,
            // fillColor: Colors.amber,
            backgroundColor: Colors.grey.shade200,
            progressColor: Colors.amber.shade600,
            // have to revert when validation logic is implemented
            percent: _todaySeconds > 0 ? _todaySeconds / 86400 : 0,
            center: CircleAvatar(
              backgroundColor: Colors.indigo.shade400,
              radius: size.height * .037,
              child: Text(
                '${(DateTime.now()).difference(widget.badHabit.createDate).inDays}d',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                  color: Colors.white,
                ),
                // 'Test'),
              ),
            ),
          ),
          title: Text(
            widget.badHabit.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.badHabit.createDate) + ' - today',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Warning!'),
                      content: const Text(
                        'Are you sure you want to delete this Habit?',
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            dispatchDeleteBadHabit(widget.badHabit.id);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Deleted!'),
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  });
            },
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }

  void dispatchDeleteBadHabit(String key) {
    BlocProvider.of<BadHabitCubit>(context).cDeleteBadHabit(key);
  }

  void dispatchSetBadHabitItemStreamValue(
      String key, StopWatchTimer stopWatchTimer) {
    BlocProvider.of<TimerStreamCubit>(context)
        .cSetStopwatchStreamValue(key, stopWatchTimer);
  }
}
