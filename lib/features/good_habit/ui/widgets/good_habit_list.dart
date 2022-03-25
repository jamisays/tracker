import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';
import 'package:tracker/features/good_habit/ui/widgets/good_habit_item.dart';

class GoodHabitList extends StatefulWidget {
  const GoodHabitList({Key? key}) : super(key: key);

  @override
  State<GoodHabitList> createState() => _GoodHabitListState();
}

class _GoodHabitListState extends State<GoodHabitList> {
  @override
  void initState() {
    BlocProvider.of<GoodHabitCubit>(context).cGetGoodHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodHabitCubit, GoodHabitState>(
      builder: (context, state) {
        if (state is GoodHabitInitial) {
          return const Center(child: Text('Loading'));
        } else if (state is LoadingGoodHabits) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Empty) {
          return const Center(child: Text('No Habits added yet'));
        } else if (state is LoadedGoodHabits) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GoodHabitItem(
                key: ValueKey(state.goodHabitsList[index].id),
                goodHabit: state.goodHabitsList[index],
              );
            },
            itemCount: state.goodHabitsList.length,
          );
        } else {
          return const Center(child: Text('Please Try Again'));
        }
      },
    );
  }
}
