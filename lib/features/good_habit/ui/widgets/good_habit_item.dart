import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';
import 'package:tracker/features/good_habit/ui/screens/good_habit_details_screen.dart';

class GoodHabitItem extends StatefulWidget {
  const GoodHabitItem({Key? key, required this.goodHabit}) : super(key: key);

  final GoodHabitModel goodHabit;

  @override
  _GoodHabitItemState createState() => _GoodHabitItemState();
}

void selectGoodHabit(BuildContext context, GoodHabitModel goodHabit) {
  Navigator.of(context).pushNamed(
    GoodHabitDetailsScreen.routeName,
    arguments: goodHabit,
  );
}

class _GoodHabitItemState extends State<GoodHabitItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectGoodHabit(context, widget.goodHabit),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigo.shade500,
            radius: 30,
            child: Text(
              '${widget.goodHabit.duration}d',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            widget.goodHabit.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.goodHabit.startDate),
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
                            dispatchDeleteGoodHabit(widget.goodHabit.id);
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

  void dispatchDeleteGoodHabit(String key) {
    BlocProvider.of<GoodHabitCubit>(context).cDeleteGoodHabit(key);
  }
}
