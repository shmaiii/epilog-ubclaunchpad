//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:client/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

DateTime now = DateTime.now();
String date = Jiffy().format('MMMM do');

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 5.0,
          leading: const Icon(
            Icons.bar_chart_rounded,
            size: 35.0,
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.search,
                size: 35.0,
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Hi Julia!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Calender",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
              ),
              InkWell(
                onTap: () {
                  print("testing");
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0XFFEDF3FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: Color(0XFF0342E9),
                      ),
                    )),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Today ($date)",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
              )
            ],
          ),
          Flexible(
              child: FutureBuilder<List<HomepageReminderDocument>>(
            future: readAllHomepageReminderDocuments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  // Let the ListView know how many items it needs to build.
                  itemCount: snapshot.data?.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final testEntry = snapshot.data?[index];
                    final time = Jiffy(testEntry?.date).format("h:mm a");
                    return Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              time,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(children: [
                        Flexible(
                            child: Column(children: [
                          ListEntry(
                            title: testEntry!.title,
                            notes: testEntry.notes,
                            type: testEntry.type,
                          ),
                          const SizedBox(height: 50)
                        ]))
                      ])
                    ]);
                  },
                  padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )),
        ]));
  }
}

const List<String> optionText = <String>[
  "Reschedule",
  "Delete",
];

class EntryInfo {
  EntryInfo(this.title, this.frequency, this.time, this.dose, this.reminderTime,
      this.textButton);

  int dose;
  String frequency;
  TimeOfDay reminderTime;
  FilledButton textButton;
  String time;
  String title;
}

// Widget for each entry in the list of reminders
class ListEntry extends StatelessWidget {
  final String title;
  final String type;
  final String notes;

  const ListEntry({
    super.key,
    required this.title,
    required this.type,
    required this.notes,
  });

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
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                backgroundColor: const Color(0xfff3f3f3),
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
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 0,
                            height: 30,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(optionText[0]))),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                            value: 1,
                            height: 20,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(optionText[1]))),
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
                          child: Text(
                            "type $type",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            notes,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: const Alignment(0.5, 1),
                        padding: const EdgeInsets.all(10.0),
                        child: ToggleButton()),
                  ),
                ],
              ),
              backgroundColor: const Color(0xfff3f3f3))),
    );
  }
}

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool pressed = false;

  void _toggleButtonText() {
    setState(() {
      pressed = !pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 83,
        height: 34,
        child: FilledButton(
          onPressed: _toggleButtonText,
          style: pressed
              ? TextButton.styleFrom(backgroundColor: Colors.purple)
              : TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 156, 94, 167)),
          child: pressed
              ? const Text('UNTAKE', style: TextStyle(fontSize: 10))
              : const Text('TAKE', style: TextStyle(fontSize: 10)),
        ));
  }
}
