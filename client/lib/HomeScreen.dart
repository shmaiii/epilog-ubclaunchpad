import 'package:flutter/material.dart';
import 'main.dart';
import 'calendar_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final _key = GlobalKey<ScaffoldState>(); // Create a key
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
            if(_key.currentState!.isDrawerOpen){
              _key.currentState!.closeDrawer()
            //close drawer, if drawer is open
            }else{
              _key.currentState!.openDrawer()
              //open drawer, if drawer is closed
            }
          }
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Hi Brug",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
          Text(
                "Today is Sunday",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
          Row(
            children: [
              Expanded (
              //start of component
              child: CalendarComponent(
                  (Colors.amber[600])!,
                  "Calendar",
                  Icon(
                            Icons.calendar_today,
                            color: Color(0XFF0342E9),
                            size: 50,
                        )
                ),
              ),
              Expanded (
              child: CalendarComponent(
                  (Colors.blue[600])!,
                  "Data visualization",
                  Icon(
                            Icons.leaderboard,
                            color: (Colors.amber[600])!,
                            size: 50,
                        )
                ),
              ), 
            ]
          ),
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
        ],
      ),
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
              child:
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            ),
            ListTile(
              leading: Icon(
                Icons.library_books,
              ),
              title: const Text('Epilepsy resources', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
              title: const Text('Preferences', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
              title: const Text('Sign out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
