import 'package:get_it/get_it.dart';

import 'package:tracker/features/bad_habit/ui/logic/timer_stream/timer_stream_cubit.dart';

// Good habits
import 'package:tracker/features/good_habit/data/data_service/add_good_habit_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/delete_good_habit_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/get_good_habits_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/update_good_habit_data_source.dart';
import 'package:tracker/features/good_habit/data/repositories/good_habit_reporitory_impl.dart';
import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';
import 'package:tracker/features/good_habit/domain/usecases/add_good_habit.dart';
import 'package:tracker/features/good_habit/domain/usecases/delete_good_habit.dart';
import 'package:tracker/features/good_habit/domain/usecases/get_good_habits.dart';
import 'package:tracker/features/good_habit/domain/usecases/update_good_habit.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';

// Bad habits
import 'package:tracker/features/bad_habit/data/data_service/add_bad_habit_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/delete_bad_habit_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/get_bad_habits_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/update_bad_habit_data_source.dart';
import 'package:tracker/features/bad_habit/data/repositories/bad_habit_reporitory_impl.dart';
import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/domain/usecases/add_bad_habit.dart';
import 'package:tracker/features/bad_habit/domain/usecases/delete_bad_habit.dart';
import 'package:tracker/features/bad_habit/domain/usecases/get_bad_habits.dart';
import 'package:tracker/features/bad_habit/domain/usecases/update_bad_habits.dart';
import 'package:tracker/features/bad_habit/data/data_service/bad_habit_relapsed_data_service.dart';
import 'package:tracker/features/bad_habit/domain/usecases/bad_habit_relapsed.dart';

final injection = GetIt.instance;

void initializeInjection() {
  //! Features

  // cubit

  injection.registerFactory(
    () => GoodHabitCubit(
      getGoodHabits: injection(),
      addGoodHabit: injection(),
      updateGoodHabit: injection(),
      deleteGoodHabit: injection(),
    ),
  );

  injection.registerFactory(
    () => BadHabitCubit(
      getBadHabits: injection(),
      addBadHabit: injection(),
      updateBadHabit: injection(),
      deleteBadHabit: injection(),
      badHabitRelapsed: injection(),
    ),
  );

  injection.registerLazySingleton(() => TimerStreamCubit());

  //! Use cases
  // Good Habits
  injection.registerLazySingleton(() => GetGoodHabits(injection()));
  injection.registerLazySingleton(() => AddGoodHabit(injection()));
  injection.registerLazySingleton(() => UpdateGoodHabit(injection()));
  injection.registerLazySingleton(() => DeleteGoodHabit(injection()));

  // Bad Habits
  injection.registerLazySingleton(() => GetBadHabits(injection()));
  injection.registerLazySingleton(() => AddBadHabit(injection()));
  injection.registerLazySingleton(() => UpdateBadHabit(injection()));
  injection.registerLazySingleton(() => DeleteBadHabit(injection()));
  injection.registerLazySingleton(() => BadHabitRelapsed(injection()));

  //! Repository
  // Good Habits
  injection.registerLazySingleton<GoodHabitRepository>(
    () => GoodHabitRepositoryImpl(
      addHabitDataService: injection(),
      getGoodHabitsDataService: injection(),
      updateHabitDataService: injection(),
      deleteHabitDataService: injection(),
    ),
  );

  // Bad Habits
  injection.registerLazySingleton<BadHabitRepository>(
    () => BadHabitRepositoryImpl(
      addHabitDataService: injection(),
      getBadHabitsDataService: injection(),
      updateHabitDataService: injection(),
      deleteHabitDataService: injection(),
      badHabitRelapsedDataService: injection(),
    ),
  );

  //! Data Service
  // ? Confusion about adding hive as an instance in the
  // ? constructor of these classes and pass here as parameter
  // Good Habits
  injection.registerLazySingleton<GetGoodHabitsDataService>(
      () => GetGoodHabitsDataServiceImpl());
  injection.registerLazySingleton<AddGoodHabitDataService>(
      () => AddGoodHabitDataServiceImpl());
  injection.registerLazySingleton<UpdateGoodHabitDataService>(
      () => UpdateGoodHabitDataServiceImpl());
  injection.registerLazySingleton<DeleteGoodHabitDataService>(
      () => DeleteGoodHabitDataServiceImpl());

  // Bad Habits
  injection.registerLazySingleton<GetBadHabitsDataService>(
      () => GetBadHabitsDataServiceImpl());
  injection.registerLazySingleton<AddBadHabitDataService>(
      () => AddBadHabitDataServiceImpl());
  injection.registerLazySingleton<UpdateBadHabitDataService>(
      () => UpdateBadHabitDataServiceImpl());
  injection.registerLazySingleton<DeleteBadHabitDataService>(
      () => DeleteBadHabitDataServiceImpl());
  injection.registerLazySingleton<BadHabitRelapsedDataService>(
      () => BadHabitRelapsedDataServiceImpl());

  //! Core

  //! External
}
