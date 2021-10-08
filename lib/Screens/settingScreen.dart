import 'package:flutter/material.dart';
import 'package:resourceview_calendar/widget/customTiles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTiles(
          //   title: 'Language',
          //   icon: Icons.chevron_right_rounded,
          //   widget: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.chevron_right,
          //       size: 24,
          //     ),
          //   ),
          // ),
          CustomTiles(
            title: 'Dark Theme',
            icon: Icons.chevron_right_rounded,
            widget: Container(
              color: Colors.white,
              height: 10,
              width: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'about',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomTiles(
            title: 'Verion ',
            icon: Icons.chevron_right_rounded,
            widget: Text('0.0.0'),
          )
        ],
      ),
    );
  }
}
