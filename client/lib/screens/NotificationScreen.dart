import 'dart:async';

import 'package:flutter/material.dart';

import '../calendar__add_icons.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../firebase/auth.dart';
import '../firebase/authenticatedRequest.dart';

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
    loadData(null);
  }

  FutureOr loadData(dynamic value) async {
    await fetchAllReminder();
    setState(() {
      isLoading = false;
    });
  }

  onDeletion() async {
    print("Deletion");
    int value = 0;
    setState(() {
      isLoading = true;
    });
    await loadData(value);
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
          title: const Text(
            'Reminders',
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 100,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => NewReminder());
                    Navigator.push(context, route).then((value) async {
                      setState(() {
                        isLoading = true;
                      });
                      await loadData(value);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Calendar_Add.apply,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ),
        body: ReminderBody(onDeletion: onDeletion),
      );
    }
  }
}

class ReminderBody extends StatelessWidget {
  final VoidCallback onDeletion;

  const ReminderBody({super.key, required this.onDeletion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(child: UpComing(onDeletion: onDeletion)),
            Expanded(child: Recent(onDeletion: onDeletion)),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------Upcoming pages------------------------------------//
// Upcomming widget inside ReminderBody
class UpComing extends StatelessWidget {
  final VoidCallback onDeletion;

  const UpComing({super.key, required this.onDeletion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Upcoming",
          style: TextStyle(color: Colors.black, fontSize: 27),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/reminder/upcoming')
                      .then((value) {
                    onDeletion();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('View All',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                ),
              )),
        ],
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: upcomingEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = upcomingEntries[index];

          return ListEntry(
              title: testEntry.title,
              type: testEntry.type,
              notes: testEntry.notes,
              reminderTime: testEntry.reminderTime,
              id: testEntry.id,
              onDeletion: onDeletion);
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
    onDeletion() {
      Navigator.pop(context);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Upcoming",
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 100,
          leading: IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.black,
                size: 40.0,
              ),
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

            return ListEntry(
                title: testEntry.title,
                type: testEntry.type,
                notes: testEntry.notes,
                reminderTime: testEntry.reminderTime,
                id: testEntry.id,
                onDeletion: onDeletion);
          },
          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
        ));
  }
}

//-------------------------------------Recent pages------------------------------------//
class Recent extends StatelessWidget {
  final VoidCallback onDeletion;
  const Recent({super.key, required this.onDeletion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Recent",
          style: TextStyle(color: Colors.black, fontSize: 27),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/reminder/recent')
                      .then((value) {
                    onDeletion();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('View All',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                ),
              )),
        ],
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: recentEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = recentEntries[index];

          return ListEntry(
              title: testEntry.title,
              type: testEntry.type,
              notes: testEntry.notes,
              reminderTime: testEntry.reminderTime,
              id: testEntry.id,
              onDeletion: onDeletion);
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
    onDeletion() {
      Navigator.pop(context);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Recent",
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 100,
          leading: IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.black,
                size: 40.0,
              ),
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

            return ListEntry(
                title: testEntry.title,
                type: testEntry.type,
                notes: testEntry.notes,
                reminderTime: testEntry.reminderTime,
                id: testEntry.id,
                onDeletion: onDeletion);
          },
          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
        ));
  }
}

//-------------------------------------General reminder list helpers------------------------------------//
// ignore: todo
// TODO: Check if global list is ok
var upcomingEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo(
      "Take Levetiracetam",
      "Medication",
      "Daily·Morning and Night, 2 pills",
      const TimeOfDay(hour: 10, minute: 0),
      "id"),
  growable: true,
);

var recentEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo(
      "Get Topiramate",
      "Medication",
      "Daily·Morning and Night, 2 pills",
      const TimeOfDay(hour: 10, minute: 0),
      "id"),
  growable: true,
);

// Data type for each reminder
class EntryInfo {
  String id;
  String title;
  String type;
  String notes;
  TimeOfDay reminderTime;

  EntryInfo(this.title, this.type, this.notes, this.reminderTime, this.id);

  // ignore: todo
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
  final String id;
  final TimeOfDay reminderTime;
  final VoidCallback onDeletion;

  const ListEntry(
      {super.key,
      required this.title,
      required this.type,
      required this.notes,
      required this.reminderTime,
      required this.id,
      required this.onDeletion});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: colorMap[type],
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: PopupMenuButton<int>(
                  constraints:
                      const BoxConstraints.expand(width: 140, height: 90),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onSelected: (value) {
                    if (value == 0) {
                      Route route = MaterialPageRoute(
                        builder: (context) => NewReminder(
                            entry: EntryInfo(
                                title, type, notes, reminderTime, id)),
                      );
                      Navigator.push(context, route).then((value) {
                        onDeletion();
                      });
                    } else {
                      // ignore: todo
                      //TODO: Try to build a alert window before you really delete this!
                      deleteReminder(id);
                      onDeletion();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      height: 30,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(optionText[0])),
                      onTap: () {},
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      value: 1,
                      height: 20,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(optionText[1])),
                      onTap: () {},
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
                    child: Text(notes,
                        style: const TextStyle(color: Colors.black))),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: const Alignment(0.5, 1),
                  child: Text(
                    reminderTime.format(context),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: colorMap[type],
        ),
      ),
    );
  }
}

//-------------------------------------New Reminder Page------------------------------------//
class NewReminder extends StatefulWidget {
  final EntryInfo? entry;
  const NewReminder({super.key, this.entry});

  @override
  NewReminderState createState() => NewReminderState();
}

class NewReminderState extends State<NewReminder> {
  String _dateString = "Select Date";
  String _timeString = "Select Time";
  ReminderData tempData = ReminderData(
      type: "type", title: "title", time: DateTime.now(), notes: "notes");
  bool update = false;
  String? id;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  void _setDataFromChild(String data) {
    setState(() {
      tempData.type = data;
    });
  }

  Future<void> updateData() async {
    if (widget.entry != null) {
      update = true;
      tempData.type = widget.entry!.type;
      tempData.title = widget.entry!.title;
      tempData.time = await getReminderGivenID(widget.entry!.id);
      // tempData.time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, widget.entry!.reminderTime.hour, widget.entry!.reminderTime.minute);
      tempData.notes = widget.entry!.notes;
      _dateString =
          '${tempData.time.year} - ${tempData.time.month} - ${tempData.time.day}';
      _timeString =
          '${tempData.time.hour} : ${tempData.time.minute} : ${tempData.time.second}';
      id = widget.entry!.id;

      setState(() {
        update = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (update) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Padding(
                padding: EdgeInsets.only(top: 90),
                child: Text(
                  "New Reminder",
                  style: TextStyle(color: Colors.black, fontSize: 35),
                )),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 150,
            leading: IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Colors.black,
                  size: 40.0,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
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
                      child: Text(
                        "Type",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )),
                    Expanded(
                        child: ReminderTypeDropDown(
                            callback: _setDataFromChild, type: tempData.type)),
                    const Expanded(
                        child: Text(
                      "Title",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                    Expanded(
                        child: TextFormField(
                      initialValue: update ? tempData.title : null,
                      onChanged: (text) {
                        tempData.title = text;
                        setState(() {});
                      },
                    )),
                    const Expanded(
                        child: Text(
                      "Date",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                    Expanded(
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: const DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2020, 1, 1),
                              maxTime: DateTime(2025, 12, 31),
                              onConfirm: (date) {
                            print('confirm $date');
                            _dateString =
                                '${date.year} - ${date.month} - ${date.day}';
                            DateTime newDate = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                tempData.time.hour,
                                tempData.time.minute,
                                tempData.time.second,
                                tempData.time.millisecond,
                                tempData.time.microsecond);
                            tempData.time = DateTime(
                                newDate.year,
                                newDate.month,
                                newDate.day,
                                newDate.hour,
                                newDate.minute,
                                newDate.second,
                                newDate.millisecond,
                                newDate.microsecond);
                            setState(() {});
                          },
                              currentTime:
                                  update ? tempData.time : DateTime.now(),
                              locale: LocaleType.en);
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
                                "  Edit",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Text(
                      "Time",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                    Expanded(
                        child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            theme: const DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true, onConfirm: (time) {
                          print('confirm $time');
                          _timeString =
                              '${time.hour} : ${time.minute} : ${time.second}';
                          DateTime newDate = DateTime(
                              tempData.time.year,
                              tempData.time.month,
                              tempData.time.day,
                              time.hour,
                              time.minute,
                              time.second,
                              tempData.time.millisecond,
                              tempData.time.microsecond);
                          tempData.time = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              newDate.hour,
                              newDate.minute,
                              newDate.second,
                              newDate.millisecond,
                              newDate.microsecond);
                          setState(() {});
                        },
                            currentTime:
                                update ? tempData.time : DateTime.now(),
                            locale: LocaleType.en);
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
                                        Icons.access_time,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Text(
                                        " $_timeString",
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
                              "  Edit",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    )),
                    const Expanded(
                        child: Text(
                      "Notes",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                    Expanded(
                        child: TextFormField(
                      maxLines: 3, // set the maximum number of lines to 3
                      initialValue: update ? tempData.notes : null,
                      decoration: const InputDecoration(
                        hintText: 'Enter your notes here', // optional hint text
                        border:
                            OutlineInputBorder(), // optional border decoration
                      ),
                      onChanged: (text) {
                        tempData.notes = text;
                        setState(() {});
                      },
                    )),
                    Expanded(
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                if (update) {
                                  await updateReminder(tempData, id!);
                                  Navigator.pop(context);
                                } else {
                                  await addReminder(tempData);
                                  Navigator.pop(context);
                                }
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),),);
                                // Navigator.pushNamed(context, '/reminder');
                              },
                              child: Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ),
                          ),
                        ])),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  elevation: 4.0,
  backgroundColor: Colors.white,
);

// List for the reminder types
const List<String> list = <String>['medication', 'appointment', 'restock'];

// Map for coloring differnt types of reminders
const Map<String, Color> colorMap = {
  'medication': Color.fromARGB(255, 237, 255, 228),
  'appointment': Color.fromARGB(255, 227, 243, 252),
  'restock': Color.fromARGB(255, 250, 248, 216),
};

// Data type for saving user inputs
class ReminderData {
  String type;
  String title;
  DateTime time;
  String notes;

  ReminderData(
      {required this.type,
      required this.title,
      required this.time,
      required this.notes});
}

var input = ReminderData(
    type: "Appointment",
    title: "Meet Aryan",
    time: DateTime(2023, 1, 1, 11, 11),
    notes: "At OC");
// var input = {"type":"Appointment", "title":"Meet Aryan", "time": DateTime(2023,1,1,11,11), "notes":"At OC"};

// Widget for reminder type dropdown
class ReminderTypeDropDown extends StatefulWidget {
  final Function(String) callback;
  String? type;

  ReminderTypeDropDown({super.key, required this.callback, this.type});

  @override
  ReminderTypeDropDownState createState() => ReminderTypeDropDownState();
}

// Widget state for reminder type dropdown
class ReminderTypeDropDownState extends State<ReminderTypeDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    if (list.contains(widget.type)) {
      dropdownValue = widget.type;
    }
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
          widget.callback(value);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }
}

//-------------------------------------Helpers for server communication------------------------------------//
// Helper for post reminders to the server
Future addReminder(ReminderData reminder) async {
  var newReminder = {
    "type": reminder.type,
    "title": reminder.title,
    "date": {
      "seconds": Timestamp.fromDate(reminder.time).seconds,
      "nanoseconds": Timestamp.fromDate(reminder.time).nanoseconds
    },
    "notes": reminder.notes
  };

  String jsonString = jsonEncode(newReminder);

  var response =
      await AuthenticatedRequest.post(path: '/calendar/', body: jsonString);

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

  var response = await AuthenticatedRequest.get(path: '/calendar/');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonList = jsonDecode(response.body)["userCalendarDocuments"];
    // print(jsonList[0]);
    for (var i = 0; i < jsonList.length; i++) {
      // print(jsonList[i]["id"].runtimeType);
      var timeobj = Timeobj.fromJson(jsonList[i]["date"]);
      var time = DateTime.fromMillisecondsSinceEpoch(
          (timeobj.seconds * 1000) + (timeobj.nanoseconds ~/ 1000000));
      // print(time.hour);
      var entry = EntryInfo(
          jsonList[i]["title"],
          jsonList[i]["type"],
          jsonList[i]["notes"],
          TimeOfDay(hour: time.hour, minute: time.minute),
          jsonList[i]["id"]);
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

// Helper for send http request to server for delete a reminder
Future<String> deleteReminder(String calendarDocId) async {
  final response =
      await AuthenticatedRequest.delete(path: '/calendar/$calendarDocId');

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete reminder');
  }
}

// Helper for update reminders given document id
Future updateReminder(ReminderData reminder, String calendarDocId) async {
  // print("enter");
  // print(reminder.time);

  var newReminder = {
    "type": reminder.type,
    "title": reminder.title,
    "date": {
      "seconds": Timestamp.fromDate(reminder.time).seconds,
      "nanoseconds": Timestamp.fromDate(reminder.time).nanoseconds
    },
    "notes": reminder.notes
  };

  String jsonString = jsonEncode(newReminder);

  var response = await AuthenticatedRequest.put(
      path: '/calendar/$calendarDocId', body: jsonString);

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

// Helper to get reminder date and time given id
Future<DateTime> getReminderGivenID(String calendarDocId) async {
  var response =
      await AuthenticatedRequest.get(path: '/calendar/$calendarDocId');

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var jsonTime = jsonDecode(response.body)["date"];
    var timeobj = Timeobj.fromJson(jsonTime);
    var time = DateTime.fromMillisecondsSinceEpoch(
        (timeobj.seconds * 1000) + (timeobj.nanoseconds ~/ 1000000));

    print(time);

    return time;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('failed to add reminder');
  }
}
