import 'package:flutter/material.dart';
import 'main.dart';
import 'calendar_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

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
        ],
      ),
    );
  }
}
