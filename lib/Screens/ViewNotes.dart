import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteScreen extends StatefulWidget {
  String title;
  String task;
  NoteScreen({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String note = 'Note';
  String color;
  Future<String> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.get(widget.title);

    // colorNumber.value = pref.get('Color');

    print('GetData==' + pref.get(widget.title).toString());
    return pref.get(widget.title);
  }

  Future<String> getColor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.get('Color');

    // colorNumber.value = pref.get('Color');

    print('Get Color' + pref.get('Color').toString());
    return pref.get('Color');
  }

  Future<String> getDescription() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.get(widget.title);

    // colorNumber.value = pref.get('Color');

    print('Get Color' + pref.get('Color').toString());
    return pref.get('Color');
  }

  Future<String> getTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.get('Task' + widget.title);

    // colorNumber.value = pref.get('Color');

    print('Get Color' + pref.get('Color').toString());
    return pref.get('Color');
  }

  Future<bool> getStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getBool('TaskDone');

    // colorNumber.value = pref.get('Color');

    print('get Bool' + pref.getBool('TaskDone').toString());
    return pref.getBool('TaskDone');
  }

  @override
  void initState() {
    getTask();
    getTask().then((value) {
      value = widget.task;
    });
    getData();
    // TODO: implement initState
    super.initState();
    getData().then((String s) {
      setState(() {
        note = s;
      });
      // print('colorNumber');
      //   print(note);
    });
    getStatus();
    getColor().then((String s) {
      setState(() {
        color = s;
      });
      // print('colorNumber');
      // print(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Box No:' + widget.title,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          // color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Selected Color:',
                //       style:
                //           TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                //     ),
                //     Container(
                //       height: 20,
                //       width: 20,
                //       color: Colors.yellow,
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Task Status',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text('Done')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Note:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          note ?? 'Empty note',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  child: Row(
                    children: [
                      Text(
                        'Task:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          widget.task ?? 'Empty task',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
