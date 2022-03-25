import 'package:awesome_select/awesome_select.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';
import 'package:tracker/features/good_habit/ui/screens/good_habit_details_screen.dart';
import 'package:tracker/utils/good_habit_utils.dart';

class EditGoodHabitScreen extends StatefulWidget {
  static const routeName = '/edit_good_habit';

  final GoodHabitModel habit;

  const EditGoodHabitScreen({Key? key, required this.habit}) : super(key: key);

  @override
  _EditGoodHabitScreenState createState() => _EditGoodHabitScreenState();
}

class _EditGoodHabitScreenState extends State<EditGoodHabitScreen> {
  final _formKeyEditGood = GlobalKey<FormBuilderState>();

  var isLoading = false;
  late String _selectedScheduleType = widget.habit.selectedScheduleType;

  List<String>? editHabitDays;

  // String value = 'fle';

  String getScheduleTypeDropdownFullForm(String name) {
    if (name == 'fix') {
      return 'Fixed';
    } else if (name == 'fle') {
      return 'Flexible';
    } else {
      return 'Repeating';
    }
  }

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
            key: _formKeyEditGood,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'habit_title',
                  initialValue: widget.habit.title,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Habit Title",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.near_me),
                  ),
                ),
                FormBuilderDropdown(
                  name: 'scheduleType',
                  items: scheduleDropdownItems2,
                  initialValue: getScheduleTypeDropdownFullForm(
                      widget.habit.selectedScheduleType),
                  onChanged: (value) {
                    setState(() {
                      _selectedScheduleType =
                          value.toString().toLowerCase().substring(0, 3);
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Frequency",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.alarm_add_rounded),
                  ),
                ),
                buildCustomContent(
                  edit: true,
                  size: size,
                  selectedScheduleType: _selectedScheduleType,
                  habitDays: widget.habit.habitDays,
                  flexDays: widget.habit.flexDays?.toString(),
                  flexPerTime: widget.habit.flexPerTime?.toString(),
                  repDays: widget.habit.repDays?.toString(),
                ),
                buildScheduleContent(widget.habit.timesDay.toString()),
                FormBuilderTextField(
                  name: 'karma_point',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Karma Point",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.score),
                  ),
                ),
                FormBuilderDropdown(
                  name: 'difficulty_level',
                  items: difficultyDropdownMenuItems,
                  initialValue: widget.habit.difficultyLevel,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.hail_rounded),
                  ),
                ),
                FormBuilderDateTimePicker(
                  name: 'start_date',
                  keyboardType: TextInputType.datetime,
                  initialValue: widget.habit.startDate,
                  firstDate: DateTime.utc(2020),
                  lastDate: DateTime.now(),
                  style: const TextStyle(),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Select Start Date",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.date_range),
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

  void _saveForm() {
    _formKeyEditGood.currentState!.save();

    int? enteredFlexDays;
    int? enteredRepDays;

    var enteredTitle =
        _formKeyEditGood.currentState!.fields['habit_title']!.value.toString();
    // final habitDays =
    //     _editGoodForm.currentState!.fields['habitDays'] as List<String>;
    enteredFlexDays = int.parse(
        _formKeyEditGood.currentState!.fields['flex_days']?.value ?? '0');
    final enteredFlexPerTime =
        _formKeyEditGood.currentState!.fields['flex_per_time']?.value;
    enteredRepDays = int.parse(
        _formKeyEditGood.currentState!.fields['rep_days']?.value ?? '0');
    final enteredTimesDay =
        int.parse(_formKeyEditGood.currentState!.fields['times_day']!.value);
    final enteredDifficulty =
        _formKeyEditGood.currentState!.fields['difficulty_level']!.value;
    final startDate =
        _formKeyEditGood.currentState!.fields['start_date']!.value as DateTime;
    int calculatedDuration = DateTime.now().difference(startDate).inDays;

    final updatedGoodHabit = GoodHabitModel(
      id: widget.habit.id,
      title: enteredTitle,
      startDate: startDate,
      cues: const [],
      duration: calculatedDuration,
      difficultyLevel: enteredDifficulty,
      selectedScheduleType: _selectedScheduleType,
      habitDays: editHabitDays,
      flexDays: enteredFlexDays,
      flexPerTime: enteredFlexPerTime,
      repDays: enteredRepDays,
      timesDay: enteredTimesDay,
      isActive: true,
    );

    dispatchUpdateGoodHabit(updatedGoodHabit);
  }

  void dispatchUpdateGoodHabit(GoodHabitModel goodHabit) {
    // DB
    BlocProvider.of<GoodHabitCubit>(context).cUpdateGoodHabit(goodHabit);
    // Routing
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(GoodHabitDetailsScreen.routeName,
        arguments: goodHabit);
    // Snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Habit updated!')));
  }

  Widget buildCustomContent({
    required bool edit,
    required Size size,
    required String selectedScheduleType,
    List<String>? habitDays,
    String? flexDays,
    String? flexPerTime,
    String? repDays,
  }) {
    switch (selectedScheduleType) {
      case 'fix':
        return SmartSelect<String>.multiple(
          title: 'Select Days',
          modalConfirm: true,
          choiceConfig: const S2ChoiceConfig(
            type: S2ChoiceType.chips,
          ),
          selectedValue: habitDays,
          onChange: (state) {
            editHabitDays = state!.value;
          },
          modalType: S2ModalType.popupDialog,
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: daysx,
            value: (index, item) => item['value']!,
            title: (index, item) => item['title']!,
          ),
        );
      // break;

      case 'fle':
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
                  name: 'flex_days',
                  initialValue: flexDays,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const Text('  days per'),
              SizedBox(
                width: 100,
                child: FormBuilderDropdown(
                  name: 'flex_per_time',
                  items: timesPerOptionsDropdownMenuItems,
                  elevation: 10,
                  initialValue: flexPerTime,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    // icon: Icon(Icons.personal_injury),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'rep':
        return Row(
          children: [
            const Text(
              'I will do this after every  ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 30,
              child: FormBuilderTextField(
                name: 'rep_days',
                initialValue: repDays,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const Text('  days.'),
          ],
        );

      default:
        return const Text('Default');
    }
  }
}
