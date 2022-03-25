import 'package:get_it/get_it.dart';

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

final injection = GetIt.instance;

void initializeInjection() {
  //! Features - Good Habit

  // cubit

  injection.registerFactory(
    () => GoodHabitCubit(
      getGoodHabits: injection(),
      addGoodHabit: injection(),
      updateGoodHabit: injection(),
      deleteGoodHabit: injection(),
    ),
  );

  // Use cases
  injection.registerLazySingleton(() => GetGoodHabits(injection()));
  injection.registerLazySingleton(() => AddGoodHabit(injection()));
  injection.registerLazySingleton(() => UpdateGoodHabit(injection()));
  injection.registerLazySingleton(() => DeleteGoodHabit(injection()));

  // Repository
  injection.registerLazySingleton<GoodHabitRepository>(
    () => GoodHabitRepositoryImpl(
      addHabitDataService: injection(),
      getGoodHabitsDataService: injection(),
      updateHabitDataService: injection(),
      deleteHabitDataService: injection(),
    ),
  );

  // Data Service
  // ? Confusion about adding hive as an instance in the
  // ? constructor of these classes and pass here as parameter

  injection.registerLazySingleton<GetGoodHabitsDataService>(
      () => GetGoodHabitsDataServiceImpl());
  injection.registerLazySingleton<AddGoodHabitDataService>(
      () => AddGoodHabitDataServiceImpl());
  injection.registerLazySingleton<UpdateGoodHabitDataService>(
      () => UpdateGoodHabitDataServiceImpl());
  injection.registerLazySingleton<DeleteGoodHabitDataService>(
      () => DeleteGoodHabitDataServiceImpl());

  //! Core

  //! External
}
