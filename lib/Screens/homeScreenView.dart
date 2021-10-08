import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:resourceview_calendar/Screens/ViewNotes.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key key}) : super(key: key);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  bool status = true;
  int index = 0;

  Future<bool> getStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getBool('TaskDone');

    // colorNumber.value = pref.get('Color');

    print(pref.getBool('TaskDone'));
    return pref.getBool('TaskDone');
  }

  String taskTitle;

  Future<int> getBoxNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt('setBoxNUmber');
    // print(pref.getInt('BoxNumber'));
    return pref.getInt('setBoxNUmber');
  }

  Future<int> getNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt('BoxNumber');
    print(pref.getInt('BoxNumber'));
    return pref.getInt('BoxNumber');
  }

  @override
  void initState() {
    bool status = true;
    getNumber().then((int i) {
      setState(() {
        indexnumber.value = i;
      });
    });
    getStatus();
    getBoxNumber();
    getBoxNumber().then((int i) {
      setState(() {
        boxNumber.value = i;
        // index = 0;
        // index = index - 1;
        print('Now Index Number In Home screen' + i.toString());
      });
    });

    getStatus().then((bool s) {
      setState(() {
        status = s;
        // status = false;
      });
      // print('colorNumber');
      print(status);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  String entertitle;
  // String selectColor;
  List<String> intvalue = [
    '0xFF000000',
    '0xFFF30565',
    '0xFFFFF3E0',
    '0xFF111991',
    '0xFFF300620',
  ];
  // List<int> selectTaskNUmber = [1, 2, 3, 6];
  List<Color> colors = [
    Colors.black,
    Colors.purple,
    Colors.orange.shade200,
    Colors.blueGrey,
    Color(0xFFFFC1D9),
  ].obs;
  Rx<int> _selectedColor = 0.obs;
  Rx<int> boxNumber = 30.obs;
  Rx<int> indexnumber = 0.obs;
  List<Icon> icons = [
    Icon(Icons.beach_access_sharp),
    Icon(Icons.track_changes),
    Icon(Icons.catching_pokemon),
    Icon(Icons.grass_outlined),
    Icon(Icons.lock_clock_outlined)
  ];
  Rx<int> iconIndex = 0.obs;

  @override
  void CustomshowBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: kgreyColor,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTitle(
                          title: 'Box Name',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 5.0),
                              child: TextFormField(
                                onChanged: (text) {
                                  entertitle = text;
                                },
                                // onFieldSubmitted:function ,
                                // TODO: on Submit Button
                                // controller: stringController,
                                cursorColor: Colors.blue[900],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Enter title',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomBottomSheetbox(
                              ontap: () async {
                                boxNumber.value = 30;
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setInt('boxNumber', 30);
                              },
                              boxnumber: '1',
                            ),
                            CustomBottomSheetbox(
                              ontap: () async {
                                boxNumber.value = 60;
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setInt('boxNumber', 60);
                              },
                              boxnumber: '2',
                            ),
                            CustomBottomSheetbox(
                              ontap: () async {
                                boxNumber.value = 90;
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setInt('boxNumber', 90);
                              },
                              boxnumber: '3',
                            ),
                            CustomBottomSheetbox(
                              ontap: () async {
                                boxNumber.value = 180;
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setInt('boxNumber', 180);
                              },
                              boxnumber: '6',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTitle(
                          title: 'Box Color',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: intvalue.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _selectedColor.value = index;
                                  print(intvalue[_selectedColor.value]);
                                  print(index);
                                },
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Color(_selectedColor == index
                                            ? int.parse(intvalue[index])
                                            : int.parse(intvalue[index])),
                                        shape: BoxShape.circle,
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: _selectedColor == index
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTitle(
                          title: 'Box Icon',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomIconButton(
                              onTp: () {
                                iconIndex.value = 0;
                              },
                              icon: Icons.beach_access_sharp,
                            ),
                            CustomIconButton(
                              onTp: () {
                                iconIndex.value = 1;
                              },
                              icon: Icons.track_changes,
                            ),
                            CustomIconButton(
                              onTp: () {
                                iconIndex.value = 2;
                              },
                              icon: Icons.catching_pokemon,
                            ),
                            CustomIconButton(
                              onTp: () {
                                iconIndex.value = 3;
                              },
                              icon: Icons.grass_outlined,
                            ),
                            CustomIconButton(
                              onTp: () {
                                iconIndex.value = 4;
                              },
                              icon: Icons.lock_clock_outlined,
                            ),
                            // CustomIconButton(
                            //   icon: Icons.tag_faces_sharp,
                            // ),
                            // CustomIconButton(
                            //   icon: Icons.bolt,
                            // ),
                            // CustomIconButton(
                            //   icon: Icons.person,
                            // ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              prefs.setString('TaskTitle', entertitle);
                              prefs.getInt('boxNumber');
                              // set box value how many box length
                              prefs.setInt('setBoxNUmber', boxNumber.value);
                              prefs.getInt('setBoxNUmber');
                              print('BoxNumber=' +
                                  prefs.getInt('boxNumber').toString());
                              prefs.setString(
                                  'Color', intvalue[_selectedColor.value]);

                              print(colors[_selectedColor.value].toString());
                            });
                            prefs.setInt('setColorValue', _selectedColor.value);
                            prefs.setInt('IconNumber', iconIndex.value);
                            prefs.setInt('BoxNumber', 1);
                            Get.back();
                          },
                          child: Text('Save'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back tO',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Box Tracker',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          CustomshowBottomSheet();
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setInt('boxNumber', 30);
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 30,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // CustomCalender(),

              Obx(() => CustomDaysNumberContainer(
                    colorSelec: status,
                    boxNumber: indexnumber.value,
                    length: boxNumber.value,

                    // boxNumber: index,
                  )),

              SizedBox(
                height: 20,
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     SharedPreferences preferences =
              //         await SharedPreferences.getInstance();
              //     preferences.get('Color');
              //     print(preferences.get('Color'));
              //   },
              //   child: Text('print'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDaysNumberContainer extends StatefulWidget {
  int length = 30;
  bool colorSelec = true;
  int boxNumber = 5;
  CustomDaysNumberContainer({
    this.length,
    this.colorSelec,
    @required this.boxNumber,
    Key key,
  }) : super(key: key);

  @override
  _CustomDaysNumberContainerState createState() =>
      _CustomDaysNumberContainerState();
}

class _CustomDaysNumberContainerState extends State<CustomDaysNumberContainer> {
  int indexNumber = 5;
  int taskNUmber;
  Future<int> getBoxNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getInt('BoxNumber');

    // colorNumber.value = pref.get('Color');

    print('number' + pref.getInt('BoxNumber').toString());
    // return pref.getBool('TaskDone');
  }

  Future<int> getTaskNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getInt('BoxNumber');

    // colorNumber.value = pref.get('Color');

    print('number' + pref.getInt('BoxNumber').toString());
    // return pref.getBool('TaskDone');
  }

  @override
  void initState() {
    getBoxNumber();
    getTaskNumber();
    bool colorSelec = true;

    getTaskNumber().then((int i) {
      setState(() {
        taskNUmber = i;
      });
    });
    super.initState();
  }

  int selectIndex;

  @override
  Widget build(BuildContext context) {
    selectIndex = widget.boxNumber;
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kgreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: GridView.builder(
          itemCount: widget.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == selectIndex) {
              print('index:' + index.toString());
              print('select index' + selectIndex.toString());

              widget.colorSelec = false;
            } else {
              // colorSelec = true;
            }
            // if (index == 2) {
            //   colorSelec = false;
            //   // Get.to(NoteScreen());
            //   index = selectIndex;
            // } else {
            //   colorSelec = true;
            // }
            int number = 0;
            number = index + 1;
            return widget.colorSelec
                ? GestureDetector(
                    onTap: () {
                      print(index);
                      String title = index.toString();

                      // colorSelec = false;
                      Get.to(NoteScreen(title: title));

                      // index = selectIndex;
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.colorSelec ? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 25,
                        width: 25,
                        child: Center(
                          child: Text(
                            number.toString(),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: widget.colorSelec ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 25,
                        width: 25,
                        child: Center(
                          child: Text(
                            index.toString(),
                          ),
                        )));
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            mainAxisSpacing: 0,
            crossAxisSpacing: 4,
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheetbox extends StatelessWidget {
  String boxnumber;
  VoidCallback ontap;
  Color color;
  CustomBottomSheetbox({
    @required this.boxnumber,
    this.ontap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        color: Colors.white,
        height: 25,
        width: 25,
        child: Center(
          child: Text(
            boxnumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  IconData icon;
  VoidCallback onTp;
  CustomIconButton({
    @required this.onTp,
    @required this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        icon,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}

class CustomCircleColorWidget extends StatelessWidget {
  Color color;
  VoidCallback onTap;
  CustomCircleColorWidget({
    @required this.color,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: color,
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  String title;
  CustomTitle({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomCalender extends StatefulWidget {
  const CustomCalender({
    Key key,
  }) : super(key: key);

  @override
  _CustomCalenderState createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  @override
  // void _onselectionChanged(DateRangePickerSelectionChangedArgs arg) {
  //   SchedulerBinding.instance!.addPostFrameCallback((duration) {
  //     setState(() {
  //       _date = DateFormat('dd, MMMM yyyy').format(arg.value).toString();
  //     });
  //   });
  //   print(arg.value);

  //   // print(rangeStartDate);qa\
  // }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final DateTime rangeStartDate = args.value.startDate;
      rangeStartDate != rangeStartDate;
      final DateTime rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }

  Widget build(BuildContext context) {
    // DateRangePickerController _controller = DateRangePickerController();
    final DateRangePickerController _controller = DateRangePickerController();
    String _date =
        DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 300,
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(
                      Duration(days: 4),
                    ),
                    DateTime.now().add(
                      Duration(days: 3),
                    ),
                  ),
                ),
                // child: SfDateRangePicker(
                //   onSelectionChanged: _onSelectionChanged,
                //   showActionButtons: true,
                //   controller: _controller,
                //   // initialDisplayDate: DateTime.now(),
                //   initialSelectedRange: PickerDateRange(
                //     DateTime.now().subtract(Duration(days: 4)),
                //     DateTime.now().add(Duration(days: 3)),
                //   ),

                //   // initialSelectedDates: [],

                //   onCancel: () {
                //     _controller.selectedRange = null;
                //   },
                //   onSubmit: (Object val) {
                //     print(val);
                //   },
                //   view: DateRangePickerView.month,
                //   // selectionMode: DateRangePickerSelectionMode.range,
                //   monthViewSettings: DateRangePickerMonthViewSettings(
                //     firstDayOfWeek: 1,
                //   ),
                // ),
              ),
              Container()
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(height: 50, child: Text('SelectedDate:' '$_date')),
      ],
    );
  }
}



















// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:resourceview_calendar/Screens/ViewNotes.dart';
// import 'package:resourceview_calendar/constants/constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';

// class HomeScreenView extends StatefulWidget {
//   const HomeScreenView({Key key}) : super(key: key);

//   @override
//   _HomeScreenViewState createState() => _HomeScreenViewState();
// }

// class _HomeScreenViewState extends State<HomeScreenView> {
//   bool status = true;
//   int index;
//   Future<bool> getStatus() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();

//     pref.getBool('TaskDone');

//     // colorNumber.value = pref.get('Color');

//     print(pref.getBool('TaskDone'));
//     return pref.getBool('TaskDone');
//   }

//   Future<int> getBoxNumber() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.getInt('BoxNumber');
//     print(pref.getInt('BoxNumber'));
//     return pref.getInt('BoxNumber');
//   }

//   @override
//   void initState() {
//     bool status;
//     getStatus();
//     getBoxNumber();
//     getBoxNumber().then((int i) {
//       setState(() {
//         index = i;
//         // index = index - 1;
//         print('Now Index Number In Home screen' + i.toString());
//       });
//     });

//     getStatus().then((bool s) {
//       setState(() {
//         status = s;
//         // status = false;
//       });
//       // print('colorNumber');
//       print(status);
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   String entertitle;
//   // String selectColor;
//   List<String> intvalue = [
//     '0xFF000000',
//     '0xFFF3E5F5',
//     '0xFF000000',
//     '0xFFF3E588',
//     '0xFF000020',
//   ];
//   List<Color> colors = [
//     Colors.black,
//     Colors.purple,
//     Colors.orange.shade200,
//     Colors.blueGrey,
//     Color(0xFFFFC1D9),
//   ].obs;
//   Rx<int> _selectedColor = 0.obs;

//   @override
//   void CustomshowBottomSheet() {
//     showModalBottomSheet<void>(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: Container(
//             color: kgreyColor,
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: Center(
//               child: Wrap(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomTitle(
//                           title: 'Box Name',
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: new BorderRadius.circular(6.0),
//                             ),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20.0, right: 5.0),
//                               child: TextFormField(
//                                 onChanged: (text) {
//                                   entertitle = text;
//                                 },
//                                 // onFieldSubmitted:function ,
//                                 // TODO: on Submit Button
//                                 // controller: stringController,
//                                 cursorColor: Colors.blue[900],
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   labelText: 'Enter title',
//                                   labelStyle: TextStyle(
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CustomBottomSheetbox(
//                               boxnumber: '1',
//                             ),
//                             CustomBottomSheetbox(
//                               boxnumber: '2',
//                             ),
//                             CustomBottomSheetbox(
//                               boxnumber: '3',
//                             ),
//                             CustomBottomSheetbox(
//                               boxnumber: '6',
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         CustomTitle(
//                           title: 'Box Color',
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           height: 60,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: intvalue.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   _selectedColor.value = index;
//                                   print(intvalue[_selectedColor.value]);
//                                   print(index);
//                                 },
//                                 child: Obx(
//                                   () => AnimatedContainer(
//                                     duration: Duration(milliseconds: 300),
//                                     margin: EdgeInsets.only(right: 10),
//                                     decoration: BoxDecoration(
//                                       color: Color(_selectedColor == index
//                                           ? int.parse(intvalue[index])
//                                           : int.parse(intvalue[index])),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     width: 40,
//                                     height: 40,
//                                     child: Center(
//                                       child: _selectedColor == index
//                                           ? Icon(
//                                               Icons.check,
//                                               color: Colors.white,
//                                             )
//                                           : Container(),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         CustomTitle(
//                           title: 'Box Icon',
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CustomIconButton(
//                               icon: Icons.beach_access_sharp,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.track_changes,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.catching_pokemon,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.grass_outlined,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.lock_clock_outlined,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.tag_faces_sharp,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.bolt,
//                             ),
//                             CustomIconButton(
//                               icon: Icons.person,
//                             ),
//                           ],
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             SharedPreferences prefs =
//                                 await SharedPreferences.getInstance();
//                             Get.back();
//                             prefs.setString(
//                                 'Color', intvalue[_selectedColor.value]);

//                             print(colors[_selectedColor.value].toString());
//                           },
//                           child: Text('Save'),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         color: Colors.grey[100],
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome back tO',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         Text(
//                           'Box Tracker',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           CustomshowBottomSheet();
//                         },
//                         icon: Icon(
//                           Icons.add_box_outlined,
//                           size: 30,
//                         ))
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // CustomCalender(),

//               CustomDaysNumberContainer(
//                 colorSelec: status,
//                 boxNumber: index,

//                 // boxNumber: index,
//               ),

//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   SharedPreferences preferences =
//                       await SharedPreferences.getInstance();
//                   preferences.get('Color');
//                   print(preferences.get('Color'));
//                 },
//                 child: Text('print'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomDaysNumberContainer extends StatefulWidget {
//   bool colorSelec;
//   int boxNumber;
//   CustomDaysNumberContainer({
//     this.colorSelec,
//     @required this.boxNumber,
//     Key key,
//   }) : super(key: key);

//   @override
//   _CustomDaysNumberContainerState createState() =>
//       _CustomDaysNumberContainerState();
// }

// class _CustomDaysNumberContainerState extends State<CustomDaysNumberContainer> {
//   int indexNumber = 5;
//   Future<int> getBoxNumber() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();

//     pref.getInt('BoxNumber');

//     // colorNumber.value = pref.get('Color');

//     print('number' + pref.getInt('BoxNumber').toString());
//     // return pref.getBool('TaskDone');
//   }

//   @override
//   void initState() {
//     getBoxNumber();
//     bool colorSelec = true;

//     getBoxNumber().then((int i) {
//       setState(() {
//         indexNumber = i;
//       });
//     });
//     super.initState();
//   }

//   int selectIndex;

//   @override
//   Widget build(BuildContext context) {
//     selectIndex = widget.boxNumber;
//     print(widget.boxNumber);
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: kgreyColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Center(
//         child: GridView.builder(
//           itemCount: 30,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             // selectIndex = index;
//             if (index == selectIndex) {
//               print('index:' + index.toString());
//               print('select index' + selectIndex.toString());

//               widget.colorSelec = false;
//             } else {
//               // colorSelec = true;
//             }
//             // if (index == 2) {
//             //   colorSelec = false;
//             //   // Get.to(NoteScreen());
//             //   index = selectIndex;
//             // } else {
//             //   colorSelec = true;
//             // }
//             int number = 0;
//             number = index + 1;
//             return widget.colorSelec
//                 ? GestureDetector(
//                     onTap: () {
//                       print("index is =" + index.toString());
//                       String title = index.toString();

//                       // colorSelec = false;
//                       Get.to(NoteScreen(title: title));

//                       // index = selectIndex;
//                     },
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: widget.colorSelec ? Colors.green : Colors.grey,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         height: 25,
//                         width: 25,
//                         child: Center(
//                           child: Text(
//                             number.toString(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Center(
//                     child: Container(
//                         decoration: BoxDecoration(
//                           color: widget.colorSelec ? Colors.green : Colors.grey,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         height: 25,
//                         width: 25,
//                         child: Center(
//                           child: Text(
//                             index.toString(),
//                           ),
//                         )));
//           },
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 50,
//             mainAxisSpacing: 0,
//             crossAxisSpacing: 4,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomBottomSheetbox extends StatelessWidget {
//   String boxnumber;
//   CustomBottomSheetbox({
//     @required this.boxnumber,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         color: Colors.white,
//         height: 25,
//         width: 25,
//         child: Center(
//           child: Text(
//             boxnumber,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomIconButton extends StatelessWidget {
//   IconData icon;
//   CustomIconButton({
//     @required this.icon,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Icon(
//         icon,
//         color: Colors.black,
//         size: 30,
//       ),
//     );
//   }
// }

// class CustomCircleColorWidget extends StatelessWidget {
//   Color color;
//   VoidCallback onTap;
//   CustomCircleColorWidget({
//     @required this.color,
//     @required this.onTap,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CircleAvatar(
//         radius: 15,
//         backgroundColor: color,
//       ),
//     );
//   }
// }

// class CustomTitle extends StatelessWidget {
//   String title;
//   CustomTitle({
//     @required this.title,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 14,
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }
// }

// class CustomCalender extends StatefulWidget {
//   const CustomCalender({
//     Key key,
//   }) : super(key: key);

//   @override
//   _CustomCalenderState createState() => _CustomCalenderState();
// }

// class _CustomCalenderState extends State<CustomCalender> {
//   @override
//   // void _onselectionChanged(DateRangePickerSelectionChangedArgs arg) {
//   //   SchedulerBinding.instance!.addPostFrameCallback((duration) {
//   //     setState(() {
//   //       _date = DateFormat('dd, MMMM yyyy').format(arg.value).toString();
//   //     });
//   //   });
//   //   print(arg.value);

//   //   // print(rangeStartDate);qa\
//   // }

//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     if (args.value is PickerDateRange) {
//       final DateTime rangeStartDate = args.value.startDate;
//       rangeStartDate != rangeStartDate;
//       final DateTime rangeEndDate = args.value.endDate;
//     } else if (args.value is DateTime) {
//       final DateTime selectedDate = args.value;
//     } else if (args.value is List<DateTime>) {
//       final List<DateTime> selectedDates = args.value;
//     } else {
//       final List<PickerDateRange> selectedRanges = args.value;
//     }
//   }

//   Widget build(BuildContext context) {
//     // DateRangePickerController _controller = DateRangePickerController();
//     final DateRangePickerController _controller = DateRangePickerController();
//     String _date =
//         DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Column(
//             children: [
//               Container(
//                 height: 250,
//                 width: 300,
//                 child: SfDateRangePicker(
//                   onSelectionChanged: _onSelectionChanged,
//                   selectionMode: DateRangePickerSelectionMode.range,
//                   initialSelectedRange: PickerDateRange(
//                     DateTime.now().subtract(
//                       Duration(days: 4),
//                     ),
//                     DateTime.now().add(
//                       Duration(days: 3),
//                     ),
//                   ),
//                 ),
//                 // child: SfDateRangePicker(
//                 //   onSelectionChanged: _onSelectionChanged,
//                 //   showActionButtons: true,
//                 //   controller: _controller,
//                 //   // initialDisplayDate: DateTime.now(),
//                 //   initialSelectedRange: PickerDateRange(
//                 //     DateTime.now().subtract(Duration(days: 4)),
//                 //     DateTime.now().add(Duration(days: 3)),
//                 //   ),

//                 //   // initialSelectedDates: [],

//                 //   onCancel: () {
//                 //     _controller.selectedRange = null;
//                 //   },
//                 //   onSubmit: (Object val) {
//                 //     print(val);
//                 //   },
//                 //   view: DateRangePickerView.month,
//                 //   // selectionMode: DateRangePickerSelectionMode.range,
//                 //   monthViewSettings: DateRangePickerMonthViewSettings(
//                 //     firstDayOfWeek: 1,
//                 //   ),
//                 // ),
//               ),
//               Container()
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         Container(height: 50, child: Text('SelectedDate:' '$_date')),
//       ],
//     );
//   }
// }
