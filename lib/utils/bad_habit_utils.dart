import 'package:flutter/material.dart';

const difficultyMenuItems = <String>[
  'Easy',
  'Medium',
  'Hard',
];

final List<DropdownMenuItem<String>> difficultyDropdownMenuItems =
    difficultyMenuItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

const frequencyTypeItems = <String>[
  'Daily',
  'Weekly',
  'Monthly',
];

final List<DropdownMenuItem<String>> frequencyTypeItemsDropdownMenuItems =
    frequencyTypeItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

final focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);

final enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);
