import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resourceview_calendar/Screens/timeMangemantScreen.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class EventTime extends StatelessWidget {
  const EventTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreyColor,
        title: Text(
          'Task Name',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeMangemantScreen(),
                ),
              );
            },
            icon: Icon(
              FontAwesomeIcons.slidersH,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: kgreyColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '25:00',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Text('Focusing'),
                  ],
                ),
              ),
              Positioned(
                top: 400,
                // left: 110,
                child: CircleAvatar(
                  // foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: GestureDetector(
                    onTap: () {
                      final stopWatchTimer = StopWatchTimer(
                        mode: StopWatchMode.countUp,
                        onChange: (value) => print('onChange $value'),
                        onChangeRawSecond: (value) =>
                            print('onChangeRawSecond $value'),
                        onChangeRawMinute: (value) =>
                            print('onChangeRawMinute $value'),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                          child: Text(
                        'GO',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
