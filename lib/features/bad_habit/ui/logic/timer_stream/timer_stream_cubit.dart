import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

part 'timer_stream_state.dart';

class TimerStreamCubit extends Cubit<TimerStreamState> {
  TimerStreamCubit() : super(TimerStreamInitial());

  Map<String, StopWatchTimer> stopwatchStreamList = {};

  void cSetStopwatchStreamValue(String id, StopWatchTimer itemStopwatch) {
    stopwatchStreamList[id] = itemStopwatch;
  }

  StopWatchTimer cGetStopwatchStreamValue(String id) {
    emit(LoadingTimerStream());
    final stream = stopwatchStreamList[id];
    emit(LoadedTimerStream(stopwatchStream: stream!));
    return stream;
  }

  void cDisposeBadItemStream(String id) {
    stopwatchStreamList[id] = null as StopWatchTimer;
  }
}
