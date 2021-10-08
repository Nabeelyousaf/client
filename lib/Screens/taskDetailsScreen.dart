import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:resourceview_calendar/Screens/reflectionNotes.dart';
import 'package:resourceview_calendar/Screens/taskTimeDetails.dart';
import 'package:resourceview_calendar/Screens/timeMangemantScreen.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:resourceview_calendar/widget/CustomGoalcontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetailScreen extends StatefulWidget {
  TaskDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  RxString tittle = 'Tittle'.obs;
  Rx<int> iconIndex = 0.obs;
  Future<String> getTittle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString('TaskTitle');
    print(pref.getString('TaskTitle'));
    return pref.getString('TaskTitle');
  }

  Future<int> getIcon() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt('IconNumber');
    print(pref.getInt('IconNumber'));
    return pref.getInt('IconNumber');
  }

  void initState() {
    getIcon();
    getIcon().then((value) {
      iconIndex.value = value;
    });
    getTittle();
    getTittle().then((value) {
      setState(() {
        tittle.value = value;
      });
    });
    super.initState();
  }

  List<Icon> icons = [
    Icon(Icons.beach_access_sharp),
    Icon(Icons.track_changes),
    Icon(Icons.catching_pokemon),
    Icon(Icons.grass_outlined),
    Icon(Icons.lock_clock_outlined)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreyColor,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.slidersH),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeMangemantScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.infinity,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Goal Dashboard',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          12.0,
                        ),
                        child: GridView.builder(
                          itemCount: 12,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Wrap(direction: Axis.horizontal, children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GoalsContainer(
                                  index: index + 1,
                                ),
                              ),
                            ]);
                          },
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 45,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                        ),
                      ),
                      // height: 250,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      child: Wrap(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No of Box Card =30 box card',
                              style: kgoalText,
                            ),
                            Text(
                              'Days learned=0%',
                              style: kgoalText,
                            ),
                            // Text(
                            //   'Longest Streak =500day',
                            //   style: kgoalText,
                            // ),
                            // Text(
                            //   'Current Streak =400 days',
                            //   style: kgoalText,
                            // )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // FractionallySizedBox(
                  //   widthFactor: 0.9,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: kgreyColor,
                  //         borderRadius: BorderRadius.circular(
                  //           20,
                  //         )),
                  //     height: 60,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 12, vertical: 8),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 FontAwesomeIcons.bullseye,
                  //                 size: 24,
                  //               ),
                  //               Text(
                  //                 'Reading',
                  //                 style: TextStyle(
                  //                   fontSize: 24,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           new LinearPercentIndicator(
                  //             width: 70,
                  //             lineHeight: 14.0,
                  //             percent: 0.5,
                  //             center: Text(
                  //               "50.0%",
                  //               style: new TextStyle(fontSize: 12.0),
                  //             ),
                  //             // trailing: Icon(Icons.mood),
                  //             linearStrokeCap: LinearStrokeCap.roundAll,
                  //             backgroundColor: Colors.grey,
                  //             progressColor: Colors.blue,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: kgreyColor,
                      borderRadius: BorderRadius.circular(
                        20,
                      )),
                  height: 60,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventTime(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              icons[iconIndex.value],
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  tittle.value ?? 'Task',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ReflectionNotesScreen()));
                          },
                          icon: Icon(Icons.arrow_right),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
