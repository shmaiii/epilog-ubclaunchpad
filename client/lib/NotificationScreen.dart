import 'package:flutter/material.dart';

import 'calendar__add_icons.dart';
import 'main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//-------------------------------------Reminder Main Pages------------------------------------//
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await fetchAllReminder();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Reminders', style: TextStyle(color: Colors.black, fontSize: 35),),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 100,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/reminder/new');
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Icon(Calendar_Add.apply, color: Colors.black,),
                ),
              )
            ),
          ],
        ),
        body: const ReminderBody(),
      );
    }
  }
}

class ReminderBody extends StatelessWidget {
  const ReminderBody({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Expanded(child: UpComing()),
            Expanded(child: Recent()),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------Upcoming pages------------------------------------//
// Upcomming widget inside ReminderBody
class UpComing extends StatelessWidget {
  const UpComing({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Upcoming", style: TextStyle(color: Colors.black, fontSize: 27),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/reminder/upcoming');
              },
              child: Container(
                alignment: Alignment.center,
                child: const Text('View All', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
              ),
            )
          ),
        ],
      ),
      body: ListView.builder(                    
        // Let the ListView know how many items it needs to build.
        itemCount: upcomingEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = upcomingEntries[index];

          return ListEntry(title: testEntry.title, type: testEntry.type, notes: testEntry.notes, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      ),
    );
  }
}

// Upcomming screen for complete list of reminders
class UpComingScreen extends StatelessWidget {
  const UpComingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Upcoming", style: TextStyle(color: Colors.black, fontSize: 35),),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black, size: 40.0,),
          ),
          onPressed: () => Navigator.pop(context),
        ), 
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: upcomingEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = upcomingEntries[index];

          return ListEntry(title: testEntry.title, type: testEntry.type, notes: testEntry.notes, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      )
    );
  }
}

//-------------------------------------Recent pages------------------------------------//
class Recent extends StatelessWidget {
  const Recent({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Recent", style: TextStyle(color: Colors.black, fontSize: 27),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/reminder/recent');
              },
              child: Container(
                alignment: Alignment.center,
                child: const Text('View All', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
              ),
            )
          ),
        ],
      ),
      body: ListView.builder(                    
        // Let the ListView know how many items it needs to build.
        itemCount: recentEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = recentEntries[index];

          return ListEntry(title: testEntry.title, type: testEntry.type, notes: testEntry.notes, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      ),
    );
  }
}

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Recent", style: TextStyle(color: Colors.black, fontSize: 35),),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black, size: 40.0,),
          ),
          onPressed: () => Navigator.pop(context),
        ), 
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: recentEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = recentEntries[index];

          return ListEntry(title: testEntry.title, type: testEntry.type, notes: testEntry.notes, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      )
    );
  }
}

//-------------------------------------General reminder list helpers------------------------------------//
// TODO: Check if global list is ok
var upcomingEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo("Take Levetiracetam", "Medication", "Daily·Morning and Night, 2 pills", const TimeOfDay(hour: 10, minute: 0)),
  growable: true,
);

var recentEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo("Get Topiramate", "Medication", "Daily·Morning and Night, 2 pills", const TimeOfDay(hour: 10, minute: 0)),
  growable: true,
);

// Data type for each reminder
class EntryInfo {
  
  String title;
  String type;
  String notes;
  TimeOfDay reminderTime;

  EntryInfo(this.title, this.type, this.notes, this.reminderTime);

  // TODO: Use these for comparison if needed
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is EntryInfo &&
  //         runtimeType == other.runtimeType &&
  //         title == other.title &&
  //         type == other.type &&
  //         notes == other.notes &&
  //         reminderTime == other.reminderTime;

  // @override
  // int get hashCode => hashValues(headline, content, link, publisheddate);
}

const List<String> optionText = <String>[
  "Reschedule",
  "Delete",
];

// Widget for each entry in the list of reminders
class ListEntry extends StatelessWidget {
  final String title;
  final String type;
  final String notes;
  final TimeOfDay reminderTime;

  const ListEntry({super.key, required this.title, required this.type, required this.notes, required this.reminderTime});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: MediaQuery. of(context). size. width,
        height: 100,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.black),),
            backgroundColor: const Color.fromARGB(255, 237, 255, 228),
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: PopupMenuButton<int>(
                  constraints: const BoxConstraints.expand(width: 140, height: 90),
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.black,),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      height: 30,
                      child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(optionText[0]))
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      value: 1,
                      height: 20,
                      child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(optionText[1]))
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(notes, style: const TextStyle(color: Colors.black))
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: const Alignment(0.5,1),
                  child: Text(reminderTime.format(context), style: const TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 237, 255, 228),
        ),
      ),
    );
  }
}

//-------------------------------------New Reminder Page------------------------------------//
String _dateString = "Not set";
String _time = "Not set";
class NewReminder extends StatelessWidget {
  const NewReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 90),
          child: Text("New Reminder", style: TextStyle(color: Colors.black, fontSize: 35),)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 150,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black, size: 40.0,),
          ),
          onPressed: () => Navigator.pop(context),
        ), 
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Type", style: TextStyle(color: Colors.black, fontSize: 20),),
                  )
                ),
                const Expanded(
                  child: ReminderTypeDropDown()
                ),
                const Expanded(child: Text("Title", style: TextStyle(color: Colors.black, fontSize: 20),)),
                const Expanded(child: TextField()),
                const Expanded(child: Text("Date", style: TextStyle(color: Colors.black, fontSize: 20),)),
                Expanded(
                    child: DropdownDatePicker(
                    locale: "en",
                    inputDecoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        helperText: '',
                        contentPadding: const EdgeInsets.all(3),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10))), // optional
                    isDropdownHideUnderline: true, // optional
                    isFormValidator: true, // optional
                    startYear: 1900, // optional
                    endYear: 2030, // optional
                    width: 0.0, // optional
                    monthFlex: 1,
                    dayFlex: 1,
                    yearFlex: 1,
                    onChangedDay: (value) => print('onChangedDay: $value'),
                    onChangedMonth: (value) => print('onChangedMonth: $value'),
                    onChangedYear: (value) => print('onChangedYear: $value'),
                    //boxDecoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                    // showDay: false,// optional
                    // dayFlex: 2,// optional
                    // locale: "zh_CN",// optional
                    // selectedDay: 3, // optional
                    // selectedMonth: 3, // optional
                    // selectedYear: 2023, // optional
                    // hintDay: 'Day', // optional
                    // hintMonth: 'Month', // optional
                    // hintYear: 'Year', // optional
                    // hintTextStyle: TextStyle(color: Colors.grey), // optional
                  )),
                const Expanded(child: Text("Time", style: TextStyle(color: Colors.black, fontSize: 20),)),
                Expanded(child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                    theme: const DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31),
                    onConfirm: (date) {
                      print('confirm $date');
                      _dateString = '${date.year} - ${date.month} - ${date.day}';
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_dateString",
                                  style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),),
                const Expanded(child: Text("Notes", style: TextStyle(color: Colors.black, fontSize: 20),)),
                Expanded(child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Container(
                          color: Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: TextButton(
                        onPressed: () => addReminder(input),
                        child: Container(
                          color: Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                  ])),
              ],
            ),
          ),
        ),
      )
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5.0)),
  elevation: 4.0,
  backgroundColor: Colors.white,
);

// List for the reminder types
const List<String> list = <String>['Medication', 'Appointment', 'Restock'];

// Data type for saving user inputs
class ReminderData {
  String type;
  String title;
  DateTime time;
  String notes;

  ReminderData({required this.type, required this.title, required this.time, required this.notes});
}

var input = ReminderData(type: "Appointment", title: "Meet Aryan", time: DateTime(2023,1,1,11,11), notes: "At OC");
// var input = {"type":"Appointment", "title":"Meet Aryan", "time": DateTime(2023,1,1,11,11), "notes":"At OC"};

// Widget for reminder type dropdown
class ReminderTypeDropDown extends StatefulWidget {
  const ReminderTypeDropDown({super.key});

  @override
  State<ReminderTypeDropDown> createState() => _ReminderTypeDropDownState();
}

// State changes to the reminder type dropdown
class _ReminderTypeDropDownState extends State<ReminderTypeDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        hint: const Text("Choose the type of the reminder"),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            input.type = value;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}

//-------------------------------------Helpers for server communication------------------------------------//
// Helper for post reminders to the server
void addReminder(ReminderData reminder) async {
  print("enter");
  print(reminder.time);

  var newReminder = {"type": reminder.type, "title": reminder.title, "date": {"seconds": Timestamp.fromDate(reminder.time).seconds, "nanoseconds": Timestamp.fromDate(reminder.time).nanoseconds},"notes": reminder.notes};

  String jsonString = jsonEncode(newReminder);

  var response = await http.post(
    Uri.parse('http://10.0.2.2:8080/calendar/Reminder_Test_User'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonString,
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // return "Success";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('failed to add reminder');
  }
}

// Object for saving the time object from json temperarily for constructing a Date time
class Timeobj {
  Timeobj({required this.seconds, required this.nanoseconds});
  final int seconds;
  final int nanoseconds;

  factory Timeobj.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final seconds = data['seconds'] as int;
    final nanoseconds = data['nanoseconds'] as int;
    return Timeobj(seconds: seconds, nanoseconds: nanoseconds);
  }
}

// Helper to fetch all reminders from server to local
fetchAllReminder() async {
  upcomingEntries.clear();
  recentEntries.clear();
  var response = await http.get(Uri.parse('http://10.0.2.2:8080/calendar/Reminder_Test_User'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonList = jsonDecode(response.body)["userCalendarDocuments"];
    // print(jsonList[0]);
    for (var i = 0; i < jsonList.length; i++) {
      // print(jsonList[i]["id"].runtimeType);
      var timeobj = Timeobj.fromJson(jsonList[i]["date"]);
      var time = DateTime.fromMillisecondsSinceEpoch((timeobj.seconds * 1000) + (timeobj.nanoseconds ~/ 1000000));
      // print(time.hour);
      var entry = EntryInfo(jsonList[i]["title"], jsonList[i]["type"], jsonList[i]["notes"], TimeOfDay(hour: time.hour, minute: time.minute));
      if (time.compareTo(DateTime.now()) < 0) {
        recentEntries.add(entry);
      } else {
        upcomingEntries.add(entry);
      }
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('failed to fetch reminders');
  }
}