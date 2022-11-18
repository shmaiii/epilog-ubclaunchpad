//import 'dart:html';
import 'package:flutter/material.dart';

import '../model/entries.dart';

class Entries extends StatefulWidget {
  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  List<EntriesModel> entries = [
    EntriesModel(title: "a"),
    EntriesModel(title: "b"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text('Welcome to Entries'),
        ),
        body: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(entries[index].title),
                ),
              )
              );
          })
    );
  }
}