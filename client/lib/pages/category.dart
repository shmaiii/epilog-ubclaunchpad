// import 'dart:html';

import 'package:flutter/material.dart';

import 'dropdown.dart';

const List<String> list1 = <String>['One', 'Two', 'Three', 'Four'];
const List<String> list2 = <String>['Red', 'Blue', 'Green', 'Yellow'];
const String hintValue = "";
const String hint1 = "hint1";
const List<String> list3 = <String>['test1', 'test2'];

class Category extends StatefulWidget {
    const Category({super.key});

    @override 
    State<Category> createState() => _Category();
}


class _Category extends State<Category>{
  
  String selectedValue = "";
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container( 
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
                    child: const Text(
                    'Category and Type',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: const Text('What category of seizure did this appear to be?',
                    style: TextStyle(fontSize: 20.0, 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3
                          )),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: const DropdownButtonExample(),
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
                style: TextStyle(fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: const DropdownButtonExample(),
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
      ),
          ),
    ));
  }


}

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});
  

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
