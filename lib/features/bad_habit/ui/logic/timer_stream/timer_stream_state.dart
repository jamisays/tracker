part of 'timer_stream_cubit.dart';

abstract class TimerStreamState extends Equatable {
  const TimerStreamState();

  @override
  List<Object> get props => [];
}

class TimerStreamInitial extends TimerStreamState {}

class LoadingTimerStream extends TimerStreamState {}

class LoadedTimerStream extends TimerStreamState {
  final StopWatchTimer stopwatchStream;

  const LoadedTimerStream({required this.stopwatchStream});

  @override
  List<Object> get props => [];
}
