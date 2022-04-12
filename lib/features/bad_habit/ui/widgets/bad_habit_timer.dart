import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:tracker/features/bad_habit/ui/logic/timer_stream/timer_stream_cubit.dart';

class BadHabitTimer extends StatefulWidget {
  const BadHabitTimer({Key? key}) : super(key: key);

  @override
  State<BadHabitTimer> createState() => _BadHabitTimerState();
}

class _BadHabitTimerState extends State<BadHabitTimer> {
  final _isHours = true;

  late String minute;
  late String second;
  late int hour;
  late int day;

  void setTime(String stream) {
    var list = stream.split(":");
    hour = int.parse(list[0]);
    day = (hour / 24).floor();
    hour = hour % 24;
    minute = list[1];
    second = list[2].substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<TimerStreamCubit, TimerStreamState>(
      builder: (context, state) {
        if (state is LoadingTimerStream) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadedTimerStream) {
          return StreamBuilder<int>(
            stream: state.stopwatchStream.rawTime,
            initialData: state.stopwatchStream.rawTime.value,
            builder: (context, snap) {
              final value = snap.data!;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value, hours: _isHours);
              setTime(displayTime);
              return SizedBox(
                width: size.width * .99,
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Elapsed Time:',
                              style: TextStyle(
                                fontSize: size.width * .05,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                                letterSpacing: size.width * .005,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          radius: size.height * .16,
                          percent:
                              (int.parse(minute) + (hour * 60)) / (24 * 60),
                          progressColor: Colors.green,
                          backgroundColor: Colors.blueGrey.shade100,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                day.toString() + ' Days',
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '$hour:$minute:$second',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontFamily: 'Helvetica',
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Please Try Again'));
        }
      },
    );
  }
}
