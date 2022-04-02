import 'package:flutter/material.dart';
import 'package:tracker/features/bad_habit/ui/screens/new_bad_habit_screen.dart';
import 'package:tracker/features/bad_habit/ui/widgets/bad_habit_list.dart';
import 'package:tracker/features/good_habit/ui/widgets/good_habit_list.dart';
// import 'package:tracker/features/good_habit/ui/screens/new_good_habit_screen.dart';

class MyHabitsScreen extends StatelessWidget {
  const MyHabitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 5,
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
            ),
            tabs: const [
              Tab(text: 'Good'),
              Tab(text: 'Bad'),
            ],
          ),
        ),
        body: const TabBarView(children: [
          GoodHabitList(),
          BadHabitList(),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () =>
              Navigator.pushNamed(context, NewBadHabitScreen.routeName),
        ),
      ),
    );
  }
}
