import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  // const RecordCard({Key? key}) : super(key: key);
  final int days;
  final String footarText;
  final IconData icon;

  const RecordCard(this.days, this.footarText, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).listTileTheme.tileColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            days.toString(),
            style: TextStyle(
              fontSize: size.height * .06,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            footarText,
            style: TextStyle(
              fontSize: size.height * .025,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
