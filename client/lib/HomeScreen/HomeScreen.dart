import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:client/HomeScreen/home_screen_controller.dart';
import 'package:client/calendar_container.dart';
import 'delete_alert_dialog.dart';
import 'reminder_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

DateTime now = DateTime.now();
String dateToday = Jiffy().format('MMMM do');

class _HomeState extends State<HomeScreen> {
  final _key = GlobalKey<ScaffoldState>(); // Create a key

  void deleteReminder(String id) {
    setState(() {
      deleteHomepageReminder(id);
    });
  }

  void rescheduleReminder(String id, String dateTime) {
    setState(() {
      updateHomepageReminderDate(id, dateTime);
    });
  }

  void updateReminderTake(String id, bool take) {
    setState(() {
      updateHomepageReminderTake(id, take);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 5.0,
        leading: IconButton(
            icon: Icon(Icons.bar_chart_rounded),
            iconSize: 35.0,
            onPressed: () => {
                  if (_key.currentState!.isDrawerOpen)
                    {
                      _key.currentState!.closeDrawer()
                      //close drawer, if drawer is open
                    }
                  else
                    {
                      _key.currentState!.openDrawer()
                      //open drawer, if drawer is closed
                    }
                }),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            "Hi, Julia",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
          ),
        ),
        Row(children: [
          Expanded(
            //start of component
            child: CalendarComponent(
                (Colors.amber[600])!,
                "Calendar",
                Icon(
                  Icons.calendar_today,
                  color: Color(0XFF0342E9),
                  size: 50,
                )),
          ),
          Expanded(
            child: CalendarComponent(
                (Colors.blue[600])!,
                "Data visualization",
                Icon(
                  Icons.leaderboard,
                  color: (Colors.amber[600])!,
                  size: 50,
                )),
          ),
        ]),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Calenghrerthjy",
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
                        style: TextStyle(color: Colors.grey, fontSize: 20.0)));
              }

              return ListView.builder(
                scrollDirection: Axis.vertical,
                // Let the ListView know how many items it needs to build.
                itemCount: homepageReminderDocuments.length,

                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final entry = homepageReminderDocuments[index];
                  final time = Jiffy(entry.date).format("h:mm a");

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
                          id: entry.id,
                          take: entry.take,
                          title: entry.title,
                          notes: entry.notes,
                          type: entry.type,
                          showDeleteAlertDialog: showDeleteAlertDialog,
                          deleteReminder: deleteReminder,
                          rescheduleReminder: rescheduleReminder,
                          updateReminderTake: updateReminderTake,
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
      ]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 80.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Settings',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.library_books,
              ),
              title: const Text('Epilepsy resources',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
              ),
              title: const Text('Preferences',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
              ),
              title: const Text('Sign out',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
