library event_calendar;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:resourceview_calendar/Screens/settingScreen.dart';
import 'package:resourceview_calendar/Screens/taskDetailsScreen.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'homeScreenView.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Rx<String> taskTitle = 'Task'.obs;
  String title = 'Home';
  @override
  void initState() {
    getTittle();
    getTittle().then((value) {
      setState(() {
        taskTitle.value = value;
      });
    });
    super.initState();
  }

  Future<String> getTittle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt('BoxNumber');
    print(pref.getString('TaskTitle'));
    return pref.getString('TaskTitle');
  }

  final _inactiveColor = kwhiteColor;
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   // title: Text("Goal DashBoard"),
        //   // centerTitle: true,
        //   backgroundColor: kgreyColor,
        // ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: kwhiteColor,
      selectedIndex: _currentIndex,
      // showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(
            FontAwesomeIcons.infinity,
          ),
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.window),
          inactiveColor: _inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          inactiveColor: _inactiveColor,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomeScreenView(),
      TaskDetailScreen(),
      // GoalDashboard(),
      EventCalendar(),
      SettingScreen()
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}

class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: kgreyColor,
          boxShadow: [
            if (showElevation)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
              ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: containerHeight,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ItemWidget(
                    item: item,
                    iconSize: iconSize,
                    isSelected: index == selectedIndex,
                    backgroundColor: bgColor,
                    itemCornerRadius: itemCornerRadius,
                    animationDuration: animationDuration,
                    curve: curve,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key key,
    @required this.item,
    @required this.isSelected,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    @required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: Container(
        // width: isSelected ? 50 : 50,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                size: iconSize,
                color: isSelected
                    ? item.activeColor.withOpacity(1)
                    : item.inactiveColor == null
                        ? item.activeColor
                        : item.inactiveColor,
              ),
              child: item.icon,
            ),
            // if (isSelected)
            //   Expanded(
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 4),
            //       child: DefaultTextStyle.merge(
            //         style: TextStyle(
            //           color: item.activeColor,
            //           fontWeight: FontWeight.bold,
            //         ),
            //         maxLines: 1,
            //         textAlign: item.textAlign,
            //         child: item.title,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    @required this.icon,
    // required this.title,
    this.activeColor = Colors.black,
    // this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  // final Widget title;
  final Color activeColor;
  final Color inactiveColor;
  // final TextAlign? textAlign;
}
