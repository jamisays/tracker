import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const difficultyMenuItems = <String>['Easy', 'Medium', 'Hard'];
const timesPerOptions = <String>['Week', 'Month', 'Year'];
var timesPerOptionsDefaultValue = 'Week';

final List<DropdownMenuItem<String>> timesPerOptionsDropdownMenuItems =
    timesPerOptions
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

final List<DropdownMenuItem<String>> difficultyDropdownMenuItems =
    difficultyMenuItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

const scheduleItems2 = <String>[
  'Fixed',
  'Flexible',
  'Repeating',
];

final List<DropdownMenuItem<String>> scheduleDropdownItems2 = scheduleItems2
    .map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
    .toList();

List<String> tempHabitDays = [];

List<Map<String, String>> daysx = [
  {'value': 'mon', 'title': 'Monday'},
  {'value': 'tue', 'title': 'Tuesday'},
  {'value': 'wed', 'title': 'Wednesday'},
  {'value': 'thu', 'title': 'Thursday'},
  {'value': 'fri', 'title': 'Friday'},
  {'value': 'sat', 'title': 'Saturday'},
  {'value': 'sun', 'title': 'Sunday'},
];

List<FormBuilderFieldOption<String>> days = const [
  FormBuilderFieldOption(value: 'Monday'),
  FormBuilderFieldOption(value: 'Tuesday'),
  FormBuilderFieldOption(value: 'Wednesday'),
  FormBuilderFieldOption(value: 'Thursday'),
  FormBuilderFieldOption(value: 'Friday'),
  FormBuilderFieldOption(value: 'Saturday'),
  FormBuilderFieldOption(value: 'Sunday'),
];

Widget buildScheduleContent(String? timesDay) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 7.5,
      right: 7.5,
    ),
    child: Row(
      children: [
        const Text(
          'I will do this  ',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: 30,
          child: FormBuilderTextField(
            name: 'times_day',
            initialValue: timesDay,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const Text('  times per day'),
      ],
    ),
  );
}
