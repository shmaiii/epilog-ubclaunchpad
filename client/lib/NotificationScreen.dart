import 'package:flutter/material.dart';

import 'calendar__add_icons.dart';
import 'main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
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

          return ListEntry(title: testEntry.title, frequency: testEntry.frequency, time: testEntry.time, dose: testEntry.dose, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      )
    );
  }
}

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

          return ListEntry(title: testEntry.title, frequency: testEntry.frequency, time: testEntry.time, dose: testEntry.dose, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      )
    );
  }
}

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
        itemCount: upcomingEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = upcomingEntries[index];

          return ListEntry(title: testEntry.title, frequency: testEntry.frequency, time: testEntry.time, dose: testEntry.dose, reminderTime: testEntry.reminderTime);
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
        itemCount: upcomingEntries.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final testEntry = upcomingEntries[index];

          return ListEntry(title: testEntry.title, frequency: testEntry.frequency, time: testEntry.time, dose: testEntry.dose, reminderTime: testEntry.reminderTime);
        },
        padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      )
    );
  }
}

final upcomingEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo("Take Levetiracetam", "Daily", "Morning and Night", 2, const TimeOfDay(hour: 10, minute: 0)),
);

final recentEntries = List<EntryInfo>.generate(
  1,
  (index) => EntryInfo("Get Topiramate", "Daily", "Morning and Night", 2, const TimeOfDay(hour: 10, minute: 0)),
);

class EntryInfo {
  String title;
  String frequency;
  String time;
  int dose;
  TimeOfDay reminderTime;

  EntryInfo(this.title, this.frequency, this.time, this.dose, this.reminderTime);
}

const List<String> optionText = <String>[
  "Reschedule",
  "Delete",
];

// Widget for each entry in the list of reminders
class ListEntry extends StatelessWidget {
  final String title;
  final String frequency;
  final String time;
  final int dose;
  final TimeOfDay reminderTime;

  const ListEntry({super.key, required this.title, required this.frequency, required this.time, required this.dose, required this.reminderTime});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("$frequency · $time", style: const TextStyle(color: Colors.black),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("$dose pills", style: const TextStyle(color: Colors.black),),
                    ),
                  ],
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
                const Expanded(child: Text("Time", style: TextStyle(color: Colors.black, fontSize: 20),)),
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
                        onPressed: () => {addReminder(input)},
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

// List for the reminder types
const List<String> list = <String>['Medication', 'Appointment', 'Restock'];

// // Data type for saving user inputs
// class ReminderData {
//   String type;
//   String title;
//   String date;
//   String time;
//   String notes;

//   ReminderData(this.type, this.title, this.date, this.time, this.notes);
// }

var input = {"type":"Appointment", "title":"Meet Aryan", "date":"2023/01/01", "time":"11:11", "notes":"At OC"};

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
            input["type"] = value;
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

Future<String> addReminder(newReminder) async {
  print("enter");
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/new_reminder'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'id': 'Reminder_Test_User',
      'reminder': newReminder,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return "Success";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('failed to add reminder');
  }
}