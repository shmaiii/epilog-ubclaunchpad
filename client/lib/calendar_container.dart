import 'package:flutter/material.dart';

class CalendarComponent extends StatelessWidget {
    CalendarComponent(
        this.color, this.text, this.child
    );
    final Color color;
    final String text;
    final Widget child;

    @override
    Widget build (BuildContext context) {
    return InkWell(
        child: Container(
            margin: const EdgeInsets.all(10.0),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: Column(
                    children: [Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            text,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: child
                    )]          
                ), 
            )),
            onTap: () {
                print("Tapped on container");
            },
        );
    }
}