library event_calendar;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resourceview_calendar/Screens/homeScreen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'color-picker.dart';

part 'timezone-picker.dart';

part 'appointment-editor.dart';

part 'resource-picker.dart';

void main() => runApp(
      GetMaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );

//ignore: must_be_immutable
class EventCalendar extends StatefulWidget {
  const EventCalendar({Key key}) : super(key: key);

  @override
  EventCalendarState createState() => EventCalendarState();
}

List<Color> _colorCollection;
List<String> _colorNames;
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
int _selectedResourceIndex = 0;
List<String> _timeZoneCollection;
DataSource _events;
Meeting _selectedAppointment;
DateTime _startDate;
TimeOfDay _startTime;
DateTime _endDate;
TimeOfDay _endTime;
bool _isAllDay;
String _subject = '';
String _notes = '';
List<CalendarResource> _employeeCollection;
List<String> _nameCollection;

class EventCalendarState extends State<EventCalendar> {
  EventCalendarState();

  List<String> _eventNameCollection;
  @override
  void initState() {
    _addResourceDetails();
    _employeeCollection = <CalendarResource>[];
    _addResources();
    _events = DataSource(getMeetingDetails(), _employeeCollection);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _selectedResourceIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }

  @override
  Widget build([BuildContext context]) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: SafeArea(
          child: SfCalendar(
            view: CalendarView.day,
            allowedViews: <CalendarView>[
              CalendarView.day,
              CalendarView.timelineDay,
              CalendarView.timelineWeek,
              CalendarView.week,
              CalendarView.timelineMonth
            ],
            dataSource: _events,
            onTap: onCalendarTapped,
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ),
      ),
    );
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    _selectedAppointment = null;
    _isAllDay = false;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _selectedResourceIndex = 0;
    _subject = '';
    _notes = '';

    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.appointments.length == 1) {
      final Meeting meetingDetails = calendarTapDetails.appointments[0];
      _startDate = meetingDetails.from;
      _endDate = meetingDetails.to;
      _isAllDay = meetingDetails.isAllDay;
      _selectedColorIndex = _colorCollection.indexOf(meetingDetails.background);
      _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
          ? 0
          : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
      _subject = meetingDetails.eventName == '(No title)'
          ? ''
          : meetingDetails.eventName;
      _notes = meetingDetails.description;
      _selectedResourceIndex =
          _nameCollection.indexOf(calendarTapDetails.resource.displayName);
      _selectedAppointment = meetingDetails;
    } else {
      final DateTime date = calendarTapDetails.date;
      _startDate = date;
      _endDate = date.add(const Duration(hours: 1));
    }
    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    Navigator.push<Widget>(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AppointmentEditor()),
    );
  }

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    // _colorNames.add('Magenta');
    // _colorNames.add('Blue');
    // _colorNames.add('Peach');
    // _colorNames.add('Gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');

    return meetingCollection;
  }

  void _addResourceDetails() {
    _nameCollection = <String>[];
    _nameCollection.add('John');
    _nameCollection.add('Bryan');
    _nameCollection.add('Robert');
    _nameCollection.add('Kenny');
  }

  void _addResources() {
    Random random = Random();
    for (int i = 0; i < _nameCollection.length; i++) {
      _employeeCollection.add(CalendarResource(
        displayName: _nameCollection[i],
        id: '000' + i.toString(),
        color: Color.fromRGBO(
            random.nextInt(255), random.nextInt(255), random.nextInt(255), 1),
      ));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source, List<CalendarResource> resourceColl) {
    appointments = source;
    // resources = resourceColl;
  }

  @override
  bool isAllDay(int index) => appointments[index].isAllDay;

  @override
  String getSubject(int index) => appointments[index].eventName;

  @override
  String getStartTimeZone(int index) => appointments[index].startTimeZone;

  @override
  String getNotes(int index) => appointments[index].description;

  @override
  String getEndTimeZone(int index) => appointments[index].endTimeZone;

  @override
  Color getColor(int index) => appointments[index].background;

  @override
  DateTime getStartTime(int index) => appointments[index].from;

  @override
  DateTime getEndTime(int index) => appointments[index].to;

  @override
  List<String> getResourceIds(int index) {
    return appointments[index].ids;
  }
}

class Meeting {
  Meeting(
      {@required this.from,
      @required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = '',
      this.ids});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
  final List<String> ids;
}
