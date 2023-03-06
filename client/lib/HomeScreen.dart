import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:client/home_screen_controller.dart';
import 'package:client/delete_alert_dialog.dart';
import 'reminder_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

DateTime now = DateTime.now();
String dateToday = Jiffy().format('MMMM do');

class _HomeState extends State<HomeScreen> {
  void deleteReminder(String id) {
    setState(() {
      deleteHomepageReminder(id);
    });
  }

  void rescheduleEntry(String id, String dateTime) {
    setState(() {
      updateHomepageReminderDateTime(id, dateTime);
    });
  }

  void updateEntryTake(String id, bool take) {
    setState(() {
      updateHomepageReminderTake(id, take);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 10.0,
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
          Row(children: const [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Hi, Julia",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
              ),
            ),
          ]),
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
                  "Today ($dateToday)",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26.0,
                  ),
                ),
              )
            ],
          ),
          Flexible(
              child: FutureBuilder<List<HomepageReminderDocument>>(
            future: readAllHomepageReminderDocuments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<HomepageReminderDocument> homepageReminderDocuments =
                    snapshot.data!;
                if (homepageReminderDocuments.isEmpty) {
                  return const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Text("No reminders for today!",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 20.0)));
                }

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  // Let the ListView know how many items it needs to build.
                  itemCount: homepageReminderDocuments.length,

                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final testEntry = homepageReminderDocuments[index];
                    final time = Jiffy(testEntry.date).format("h:mm a");

                    return Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              time,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(children: [
                        Flexible(
                            child: Column(children: [
                          ReminderEntry(
                            id: testEntry.id,
                            take: testEntry.take,
                            title: testEntry.title,
                            notes: testEntry.notes,
                            type: testEntry.type,
                            showDeleteAlertDialog: showDeleteAlertDialog,
                            deleteReminder: deleteReminder,
                            rescheduleEntry: rescheduleEntry,
                            updateEntryTake: updateEntryTake,
                          ),
                          const SizedBox(height: 10)
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
