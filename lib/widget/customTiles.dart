import 'package:flutter/material.dart';
import 'package:resourceview_calendar/constants/constant.dart';

class CustomTiles extends StatelessWidget {
  const CustomTiles({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.widget,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: kgreyColor,
            borderRadius: BorderRadius.circular(
              12,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              widget
            ],
          ),
        ),
      ),
    );
  }
}
