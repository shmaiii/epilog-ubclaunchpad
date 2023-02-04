// import 'dart:html';

import 'package:flutter/material.dart';

import 'dropdown.dart';

const List<String> types = <String>[
  'Type1',
  'Type2',
  'Type3',
  'Type4',
];

const List<String> categories = <String>[
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
          padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: const Text('What category of seizure did this appear to be?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
          child: const DropdownButtonExample(list: categories),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: const Text('What type of seizure did this appear to be?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
          child: const DropdownButtonExample(list: types),
        )
      ],
    );
  }
}
