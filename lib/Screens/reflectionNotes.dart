import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resourceview_calendar/Screens/homeScreen.dart';
import 'package:resourceview_calendar/constants/constant.dart';
import 'package:resourceview_calendar/numberController.dart';
import 'package:resourceview_calendar/widget/customDescription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReflectionNotesScreen extends StatefulWidget {
  const ReflectionNotesScreen({Key key}) : super(key: key);

  @override
  _ReflectionNotesScreenState createState() => _ReflectionNotesScreenState();
}

class _ReflectionNotesScreenState extends State<ReflectionNotesScreen> {
  Rx<int> colorNumber = 0.obs;
  int firstnum;
  int indeNumber;
  int prevNumber = 1;
  // getindex value
  Future<int> getBoxNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt('BoxNumber');

    pref.getInt('setColorValue');
    print(pref.getInt('BoxNumber'));
    return pref.getInt('BoxNumber');
  }

  Future<int> getColorIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.getInt('BoxNumber');

    print(pref.getInt('setColorValue'));
    return pref.getInt('setColorValue');
  }

  // get color
  Future<String> getColor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getInt('setColorValue');

    // colorNumber.value = pref.get('Color');

    print(pref.get('Color'));
    return pref.get('Color');
  }

  // String getString() {
  //   final color = getColor();
  //   // return color.toString();
  // }

  @override
  void initState() {
    getColorIndex();
    getColorIndex().then((value) {
      colorNumber.value = value;
    });
    // getColor();
    getBoxNumber();
    // Get.put(Example());
    getBoxNumber().then((int i) {
      setState(() {
        indeNumber = i;

        print('Before current index' + indeNumber.toString());
        indeNumber++;
        print('After current index' + indeNumber.toString());
      });
    });
    // Get.find();

    // getColor().then((String s) {
    //   setState(() {
    //     colorNumber.value = s;
    //   });
    //   print('colorNumber');
    //   print(colorNumber);
    // });

    // print(colorNumber);

    // print(colorNumber.value);
    // color = getColor();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String descriptions;
    String task;
    bool validateDescription(String description) {
      if (description.isEmpty || description.length < 10) {
        return false;
      }
      return true;
    }

    List<String> intvalue = [
      '0xFF000000',
      '0xFFF30565',
      '0xFFFFF3E0',
      '0xFF111991',
      '0xFFF300620',
    ];

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
        child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // child: TextFormField(
                  //   maxLines: 10,
                  // ),
                  Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            DescriptionTextField(
                              labelText: 'Reflection Notes',
                              onSave: (String description) {
                                description = description;
                              },
                              validator: (String description) {
                                if (!validateDescription(description)) {
                                  return 'write 200 words';
                                } else {
                                  descriptions = description;
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              color: Color(
                                      int.parse(intvalue[colorNumber.value])) ??
                                  Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Column(
                        children: [
                          CustomTaskConatiner(
                            title: 'Tasks',
                          ),
                          CustomTaskConatiner(
                            title: 'Task1',
                          ),
                          CustomTaskConatiner(
                            title: 'Task2',
                          ),
                          CustomTaskConatiner(
                            title: 'Task3',
                          ),
                          CustomTaskConatiner(
                            title: 'Task4',
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTaskConatiner(
                            title: 'idea',
                          ),
                          CustomTaskTextField(
                            onSave: (String tasks) {
                              task = tasks;
                            },
                          ),
                          CustomTaskTextField(
                            onSave: (String tasks) {
                              task = tasks;
                            },
                          ),
                          CustomTaskTextField(
                            onSave: (String tasks) {
                              task = tasks;
                            },
                          ),
                          CustomTaskTextField(
                            onSave: (String tasks) {
                              task = tasks;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          child: Text('Save Note'),
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }

                            // insatance of the SharedPreference
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            // String Set in Index Number
                            preferences.setString(
                                indeNumber.toString(), descriptions);
                            preferences.setString(
                                'Task' + indeNumber.toString(), task);
                            // chack bool value but im not use right Now For other reason
                            preferences.setBool('TaskDone', true);
                            print(indeNumber);

                            preferences.setInt('BoxNumber', indeNumber);
                            print('Now Index number=' + indeNumber.toString());

                            // preferences.setInt('BoxNumber', indeNumber);
                            Get.to(MyHomePage());

                            // preferences.setStringList('Note', )
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTaskTextField extends StatelessWidget {
  String title;
  final void Function(String) onSave;

  // bool textfiled = true;

  CustomTaskTextField({
    this.onSave,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: TextFormField(
            onSaved: onSave,
          ),
        ),
      ),
      height: 50,
      width: 100,
      // color: Colors.,
      decoration: BoxDecoration(
          color: kgreyColor,
          border: Border.all(
            color: Colors.grey,
          )),
    );
  }
}

class CustomTaskConatiner extends StatelessWidget {
  String title;
  bool textfiled = true;

  CustomTaskConatiner({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: textfiled
              ? Text(
                  title,
                )
              : TextFormField(),
        ),
      ),
      height: 50,
      width: 100,
      // color: Colors.,
      decoration: BoxDecoration(
          color: kgreyColor,
          border: Border.all(
            color: Colors.grey,
          )),
    );
  }
}

class CustomTaskTileConatiner extends StatelessWidget {
  String title;

  CustomTaskTileConatiner({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          title,
        ),
      ),
      height: 50,
      width: 100,
      // color: Colors.,
      decoration: BoxDecoration(
          color: kgreyColor,
          border: Border.all(
            color: Colors.grey,
          )),
    );
  }
}
