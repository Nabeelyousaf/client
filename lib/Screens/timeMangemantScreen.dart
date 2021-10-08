import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:resourceview_calendar/constants/constant.dart';

class Workcontroller extends GetxController {
  var counter = 0.obs;

  void increment() => counter.value++;
  void decrement() => counter.value--;
}

class Shortcontroller extends GetxController {
  var counter = 0.obs;

  void increment() => counter.value++;
  void decrement() => counter.value--;
}

class LongController extends GetxController {
  var counter = 0.obs;

  void increment() => counter.value++;
  void decrement() => counter.value--;
}

class Longbreakcontroller extends GetxController {
  var counter = 0.obs;

  void increment() => counter.value++;
  void decrement() => counter.value--;
}

class TimeMangemantScreen extends StatefulWidget {
  const TimeMangemantScreen({Key key}) : super(key: key);

  @override
  _TimeMangemantScreenState createState() => _TimeMangemantScreenState();
}

class _TimeMangemantScreenState extends State<TimeMangemantScreen> {
  @override
  Widget build(BuildContext context) {
    Rx<int> number = 0.obs;
    Workcontroller WorkCont = Get.put(Workcontroller());
    Shortcontroller shcontroller = Get.put(Shortcontroller());
    LongController longCont = Get.put(LongController());
    Longbreakcontroller longbreakcont = Get.put(Longbreakcontroller());
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreyColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  'Intervals',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  color: kgreyColor,
                  child: Column(
                    children: [
                      Obx(() => CustomMangementTile(
                            decrement: WorkCont.decrement,
                            increment: WorkCont.increment,
                            num: WorkCont.counter.value,
                            title: 'Work Duration (min)',
                          )),
                      Obx(() => CustomMangementTile(
                            decrement: WorkCont.decrement,
                            increment: shcontroller.increment,
                            num: shcontroller.counter.value,
                            title: 'Short Break (min)',
                          )),
                      Obx(() => CustomMangementTile(
                            decrement: longCont.decrement,
                            increment: longCont.increment,
                            num: longCont.counter.value,
                            title: 'Long Break (min)',
                          )),
                      Obx(() => CustomMangementTile(
                            decrement: longbreakcont.decrement,
                            increment: longbreakcont.increment,
                            num: longbreakcont.counter.value,
                            title: 'Long Break Frequancy',
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  'Configurations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  color: kgreyColor,
                  child: Column(
                    children: [
                      CustomTile(
                        title: 'Flipp over the phone to start focuse',
                        button: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.white,
                          activeColor: Colors.grey,
                        ),
                      ),
                      // CustomTile(
                      //   button: Switch(
                      //     value: isSwitched,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         isSwitched = value;
                      //         print(isSwitched);
                      //       });
                      //     },
                      //     activeTrackColor: Colors.white,
                      //     activeColor: Colors.grey,
                      //   ),
                      //   title: 'put phone on Do Not Disturb Mode',
                      // ),
                      // CustomTile(
                      //   button: Switch(
                      //     value: isSwitched,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         isSwitched = value;
                      //         print(isSwitched);
                      //       });
                      //     },
                      //     activeTrackColor: Colors.white,
                      //     activeColor: Colors.grey,
                      //   ),
                      //   title: 'Auto-smart time',
                      // ),
                      // CustomTile(
                      //   button: Switch(
                      //     value: isSwitched,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         isSwitched = value;
                      //         print(isSwitched);
                      //       });
                      //     },
                      //     activeTrackColor: Colors.white,
                      //     activeColor: Colors.grey,
                      //   ),
                      //   title: 'Keep the screen on ',
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  'Notification',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  color: kgreyColor,
                  child: Column(
                    children: [
                      CustomTile(
                        title: 'Vibractions',
                        button: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.white,
                          activeColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Reset Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

class CustomMangementTile extends StatelessWidget {
  VoidCallback increment;
  VoidCallback decrement;
  String title;
  int num = 0;

  CustomMangementTile({
    this.num,
    this.decrement,
    this.increment,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey[100],
                child: Center(
                  child: IconButton(
                    onPressed: decrement,
                    icon: Icon(
                      Icons.minimize,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.white,
                height: 20,
                width: 20,
                child: Center(child: Text(num.toString())),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey[200],
                child: Center(
                  child: IconButton(
                    onPressed: increment,
                    icon: Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  String title;
  Widget button;

  CustomTile({
    @required this.button,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          button,
        ],
      ),
    );
  }
}
