import 'package:flutter/material.dart';

class GoalsContainer extends StatelessWidget {
  int index;
  GoalsContainer({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Text(
        index.toString(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      )),
      height: 20,
      width: 30,
    );
  }
}
