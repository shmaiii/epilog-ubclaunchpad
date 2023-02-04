import 'package:flutter/material.dart';

class CalendarComponent extends StatelessWidget {
    @override
    Widget build (BuildContext context) {
    return InkWell(
        child: Container(
            margin: const EdgeInsets.all(10.0),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: Column(
                    children: [Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            "Calendar",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                            Icons.calendar_today,
                            color: Color(0XFF0342E9),
                            size: 50,
                        )
                    )]          
                ), 
            )),
            onTap: () {
                print("Tapped on container");
            },
        );
    }
}