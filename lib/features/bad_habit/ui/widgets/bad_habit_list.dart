import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/ui/widgets/bad_habit_item.dart';

class BadHabitList extends StatefulWidget {
  const BadHabitList({Key? key}) : super(key: key);

  @override
  State<BadHabitList> createState() => _BadHabitListState();
}

class _BadHabitListState extends State<BadHabitList> {
  @override
  void initState() {
    BlocProvider.of<BadHabitCubit>(context).cGetBadHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadHabitCubit, BadHabitState>(
      builder: (context, state) {
        if (state is BadHabitInitial) {
          return const Center(child: Text('Loading'));
        } else if (state is LoadingBadHabits) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Empty) {
          return const Center(child: Text('No Habits added yet'));
        } else if (state is LoadedBadHabits) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return BadHabitItem(
                key: ValueKey(state.badHabitsList[index].id),
                badHabit: state.badHabitsList[index],
              );
            },
            itemCount: state.badHabitsList.length,
          );
        } else {
          return const Center(child: Text('Please Try Again'));
        }
      },
    );
  }
}
