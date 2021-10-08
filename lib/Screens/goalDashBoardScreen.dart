import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:resourceview_calendar/widget/CustomGoalcontainer.dart';

class GoalDashboard extends StatelessWidget {
  const GoalDashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                        'No of Box Card =90 box card',
                        style: kgoalText,
                      ),
                      Text(
                        'Days learned=40%',
                        style: kgoalText,
                      ),
                      Text(
                        'Longest Streak =500day',
                        style: kgoalText,
                      ),
                      Text(
                        'Current Streak =400 days',
                        style: kgoalText,
                      )
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
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
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bullseye,
                            size: 24,
                          ),
                          Text(
                            'Reading',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      new LinearPercentIndicator(
                        width: 70,
                        lineHeight: 14.0,
                        percent: 0.5,
                        center: Text(
                          "50.0%",
                          style: new TextStyle(fontSize: 12.0),
                        ),
                        // trailing: Icon(Icons.mood),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
