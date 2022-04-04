import 'package:flutter/material.dart';

class ShowAlertDialog {
  ShowAlertDialog(BuildContext context);

  final relapseReasonController = TextEditingController();

  Future<String?> showBadHabitRelapseReasonDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('What made you relapse?'),
          content: Card(
            child: TextField(
              controller: relapseReasonController,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                Navigator.pop(ctx, relapseReasonController.value.text);
                relapseReasonController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
