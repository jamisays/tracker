import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/utils/bad_habit_utils.dart';

class NewBadHabitScreen extends StatefulWidget {
  static const routeName = '/new_bad_habit';

  const NewBadHabitScreen({Key? key}) : super(key: key);

  @override
  _NewBadHabitScreenState createState() => _NewBadHabitScreenState();
}

class _NewBadHabitScreenState extends State<NewBadHabitScreen> {
  final _formKeyBad = GlobalKey<FormBuilderState>();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Bad Habit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FormBuilder(
            key: _formKeyBad,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'habit_title',
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    contentPadding: EdgeInsets.all(size.height * .02),
                    hintText: "Habit Title",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.near_me),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                const SizedBox(height: 3),
                FormBuilderDropdown(
                  name: 'done_frequency',
                  items: frequencyTypeItemsDropdownMenuItems,
                  initialValue: frequencyTypeItems[0],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Choose Frequency",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.alarm_add_rounded),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                FormBuilderTextField(
                  name: 'times_day',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "How many times?",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.timer_sharp),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                const SizedBox(height: 3),
                FormBuilderTextField(
                  name: 'cost_per_time',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Cost per time",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.money),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                const SizedBox(height: 3),
                FormBuilderDropdown(
                  name: 'difficulty_level',
                  items: difficultyDropdownMenuItems,
                  initialValue: difficultyMenuItems[0],
                  elevation: 10,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.personal_injury),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                const SizedBox(height: 3),
                FormBuilderDateTimePicker(
                  name: 'start_date',
                  keyboardType: TextInputType.datetime,
                  firstDate: DateTime.utc(2020),
                  lastDate: DateTime.now(),
                  style: const TextStyle(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Select Start Date",
                    alignLabelWithHint: false,
                    prefixIcon: const Icon(Icons.date_range),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Submit button
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: _submitData,
                    style: ButtonStyle(
                      alignment: Alignment.bottomRight,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check),
                        Text('Add Habit'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    setState(() {
      isLoading = true;
    });

    final enteredTitle =
        _formKeyBad.currentState!.fields['habit_title']!.value.toString();
    final enteredDoneFrequency =
        _formKeyBad.currentState!.fields['done_frequency']!.value;
    final enteredTimesDay =
        int.parse(_formKeyBad.currentState!.fields['times_day']!.value);
    final enteredCostPerTime =
        int.parse(_formKeyBad.currentState!.fields['cost_per_time']!.value);
    final enteredDifficultyLevel =
        _formKeyBad.currentState!.fields['difficulty_level']!.value;
    final enteredStartDate =
        _formKeyBad.currentState!.fields['start_date']!.value as DateTime;

    List<String> enteredReasonList = [];

    final badHabit = BadHabitModel(
      id: enteredStartDate.toString(),
      title: enteredTitle,
      createDate: enteredStartDate,
      reasons: enteredReasonList,
      difficultyLevel: enteredDifficultyLevel,
      timesType: enteredDoneFrequency,
      timesDay: enteredTimesDay,
      costPerTime: enteredCostPerTime,
      isActive: true,
    );

    try {
      dispatchAddBadHabit(badHabit);
    } catch (error) {
      await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(
                  'Warning!',
                ),
                content: Text(
                  error.toString(),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void dispatchAddBadHabit(BadHabitModel badHabit) {
    BlocProvider.of<BadHabitCubit>(context).cAddBadHabit(badHabit);
    // for snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New Habit Added!')));
  }
}
