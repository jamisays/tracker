// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/ui/logic/bad_habit/bad_habit_cubit.dart';
import 'package:tracker/features/bad_habit/ui/screens/bad_habit_details_screen.dart';
import 'package:tracker/utils/bad_habit_utils.dart';

class EditBadHabitScreen extends StatefulWidget {
  static const routeName = '/edit_bad_habit';

  final BadHabitModel habit;

  const EditBadHabitScreen({Key? key, required this.habit}) : super(key: key);

  @override
  _EditBadHabitScreenState createState() => _EditBadHabitScreenState();
}

class _EditBadHabitScreenState extends State<EditBadHabitScreen> {
  final _formKeyEditBad = GlobalKey<FormBuilderState>();

  var isLoading = false;
  late String selectedScheduleType = widget.habit.timesType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Habit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FormBuilder(
            key: _formKeyEditBad,
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
                  initialValue: widget.habit.timesType,
                  onChanged: (value) => selectedScheduleType = value.toString(),
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
                  initialValue: widget.habit.timesDay.toString(),
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
                  initialValue: widget.habit.costPerTime.toString(),
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
                  initialValue: widget.habit.difficultyLevel.toString(),
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
                  initialValue: widget.habit.createDate,
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
                    onPressed: _saveForm,
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
                        Text('Edit Habit'),
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

  void _saveForm() {
    _formKeyEditBad.currentState!.save();

    final enteredTitle =
        _formKeyEditBad.currentState!.value['habit_title'].toString();
    final enteredDoneFrequency =
        _formKeyEditBad.currentState!.fields['done_frequency']!.value;
    final enteredTimesDay =
        int.parse(_formKeyEditBad.currentState!.value['times_day'].toString());
    final enteredCostPerTime = int.parse(
        _formKeyEditBad.currentState!.value['cost_per_time'].toString());
    final enteredDifficultyLevel =
        _formKeyEditBad.currentState!.fields['difficulty_level']!.value;
    final enteredCreateDate =
        _formKeyEditBad.currentState!.fields['start_date']!.value as DateTime;

    List<DateTime>? relapsedDaysList = widget.habit.relapsedDaysList;
    Map<DateTime, String>? relapsedReasons = widget.habit.relapsedReasons;

    //? If Start Date is aheaden
    if (enteredCreateDate.isAfter(widget.habit.createDate)) {
      relapsedDaysList = [];
      relapsedReasons = {};
    }

    List<String> enteredReasonList = [];

    final badHabit = BadHabitModel(
      id: widget.habit.id,
      title: enteredTitle,
      createDate: enteredCreateDate,
      reasons: enteredReasonList,
      difficultyLevel: enteredDifficultyLevel,
      timesType: enteredDoneFrequency,
      timesDay: enteredTimesDay,
      costPerTime: enteredCostPerTime,
      relapsedDaysList: relapsedDaysList,
      relapsedReasons: relapsedReasons,
      isActive: true,
    );

    dispatchUpdateBadHabit(badHabit);
  }

  void dispatchUpdateBadHabit(BadHabitModel badHabit) {
    // DB
    BlocProvider.of<BadHabitCubit>(context).cUpdateBadHabit(badHabit);
    // Routing
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(BadHabitDetailsScreen.routeName,
        arguments: badHabit);
    // Snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Habit updated!')));
  }
}
