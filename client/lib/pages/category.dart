// import 'dart:html';

import 'package:flutter/material.dart';

import 'dropdown.dart';

const List<String> list1 = <String>[
  'Category1',
  'Category2',
  'Category3',
  'Category4'
];

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _Category();
}

class _Category extends State<Category> {
  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
          child: const Text(
            'Category and Type',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: const Text('What category of seizure did this appear to be?',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3)),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: const DropdownButtonExample(list: list1),
        ),
        // Container(
        //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 35),
        //     child: DropdownButton<String>(
        //       value: selectedValue,
        //       items: <String>['A', 'B', 'C', 'D'].map((String value) {
        //         return DropdownMenuItem<String>(
        //           value: value,
        //           child: Text(value),
        //         );
        //       }).toList(),
        //       onChanged: (String? newValue){
        //         setState(() {
        //         selectedValue = newValue!;
        //   });
        // },
        // ),
        // ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: const Text('What type of seizure did this appear to be?',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0)),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: DropdownButtonExample(list: list1),
        )
        // Container(
        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 35),
        // child: DropdownButton<String>(
        //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        //   onChanged: (_) {},
        // ),
        // )
      ],
    );
  }
}
