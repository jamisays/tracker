import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/ui/logic/cubit/good_habit_cubit.dart';
import 'package:tracker/utils/good_habit_utils.dart';

class NewGoodHabitScreen extends StatefulWidget {
  static const routeName = '/new_good_habit';

  const NewGoodHabitScreen({Key? key}) : super(key: key);

  @override
  _NewGoodHabitScreenState createState() => _NewGoodHabitScreenState();
}

class _NewGoodHabitScreenState extends State<NewGoodHabitScreen> {
  final _formKeyGood = GlobalKey<FormBuilderState>();

  var isLoading = false;
  bool _selectAllDaysCheckboxValue = false;
  String _selectedScheduleType = 'fix';
  List<String>? newHabitDays = [];

  Widget selectAllDays() {
    return Checkbox(
        value: _selectAllDaysCheckboxValue,
        onChanged: (value) {
          if (value == true) {
            setState(() {
              tempHabitDays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
              newHabitDays = tempHabitDays;
              _selectAllDaysCheckboxValue = true;
            });
          } else {
            setState(() {
              tempHabitDays = [];
              newHabitDays = tempHabitDays;
              _selectAllDaysCheckboxValue = false;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Good Habit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: FormBuilder(
            key: _formKeyGood,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'habit_title',
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
                  initialValue: scheduleItems2[0],
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
                  edit: false,
                  size: size,
                  selectedScheduleType: _selectedScheduleType,
                  habitDays: newHabitDays,
                  flexDays: null,
                  flexPerTime: timesPerOptions[0],
                  repDays: null,
                ),
                buildScheduleContent(null),
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
                  dropdownColor: Colors.lightBlue[100],
                  initialValue: difficultyMenuItems[0],
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
                  firstDate: DateTime.utc(2020),
                  lastDate: DateTime.now(),
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

    int? enteredFlexDays;
    int? enteredRepDays;
    String? enteredFlexPerTime;

    var enteredTitle =
        _formKeyGood.currentState!.fields['habit_title']!.value.toString();
    enteredFlexDays =
        int.parse(_formKeyGood.currentState!.fields['flex_days']?.value ?? '0');
    enteredFlexPerTime =
        _formKeyGood.currentState!.fields['flex_per_time']?.value;
    enteredRepDays =
        int.parse(_formKeyGood.currentState!.fields['rep_days']?.value ?? '0');
    final enteredTimesDay =
        int.parse(_formKeyGood.currentState!.fields['times_day']!.value);
    final enteredDifficulty =
        _formKeyGood.currentState!.fields['difficulty_level']!.value;
    final startDate =
        _formKeyGood.currentState!.fields['start_date']!.value as DateTime;
    int calculatedDuration = DateTime.now().difference(startDate).inDays;

    final goodHabit = GoodHabitModel(
      id: DateTime.now().toString(),
      title: enteredTitle,
      startDate: startDate,
      cues: const [],
      duration: calculatedDuration,
      difficultyLevel: enteredDifficulty,
      selectedScheduleType: _selectedScheduleType,
      habitDays: newHabitDays,
      flexDays: enteredFlexDays,
      flexPerTime: enteredFlexPerTime,
      repDays: enteredRepDays,
      timesDay: enteredTimesDay,
      isActive: true,
    );

    try {
      dispatchAddGoodHabit(goodHabit);
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

  void dispatchAddGoodHabit(GoodHabitModel goodHabit) {
    BlocProvider.of<GoodHabitCubit>(context).cAddGoodHabit(goodHabit);
    // add(AddGoodHabitEvent(goodHabit));
    // for snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('New Habit Added!')));
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
            newHabitDays = state!.value;
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
