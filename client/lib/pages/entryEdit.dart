import 'dart:collection';

import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';

import '../model/entries.dart';

class entryEdit extends StatelessWidget {
  String userId;
  EntriesModel entry;
  entryEdit({required this.userId, required this.entry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(),
          body: EntryEditForm(entry: entry, userId: userId),
        ),
      ),
    );
  }
}

class EntryEditForm extends StatefulWidget {
  EntriesModel entry;
  String userId;
  EntryEditForm({super.key, required this.entry, required this.userId});
  @override
  State<EntryEditForm> createState() => _EntryEditFormState(entry: entry, userId: userId);
}

class _EntryEditFormState extends State<EntryEditForm> {
  EntriesModel entry;
  String userId;
  Map<String, String> updatedValues = new Map();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _EntryEditFormState({required this.entry, required this.userId});

  
  @override
  Widget build(BuildContext context) {
    var seizureKeyList = ["Title", "Duration", "Category", "Symptoms"];
    var seizureValueList = [entry.title,"${entry.duration} minutes", entry.category, entry.symptoms];
    return Form(
        key: _formKey,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Seizure Information',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    _FormTextInput(entry: entry, updatedValues: updatedValues),
                    Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          //todo: adding a message the info got updated correctly
                          ElevatedButton(
                            onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState!.validate()) {
                                  // Process data.
                                }
                                for (MapEntry<String, String> element in updatedValues.entries) {
                                  switch (element.key) {
                                    case "Title":
                                      entry.title = element.value;
                                      break;
                                    case "Duration":
                                      entry.duration = int.parse(element.value);
                                      break;
                                    case "Category":
                                      entry.category = element.value;
                                      break;
                                    case "Symptom":
                                      entry.symptoms = element.value;
                                      break;
                                  }
                                }
                                EntryManager.update(entry, userId);
                            },
                            child: const Text('Submit'),
                          ),
                        ])
                  ])
              )
            )
        );
  }
}

@immutable
class _FormTextInput extends StatelessWidget {

  _FormTextInput({
    required this.entry,
    required this.updatedValues
  });
  EntriesModel entry;
  Map<String, String> updatedValues;
  final double itemWidth = 9;
  final double itemHeight = 3;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: 
        //Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                children: [
                  gridKey("Title"),
                  gridValue(entry.title, entry, "Title"),
                  gridKey("Duration"),
                  gridValue("${entry.duration} minutes", entry, "Duration"),
                  gridKey("Category"),
                  gridValue(entry.category, entry, "Category"),
                  gridKey("Symptoms"),
                  gridValue(entry.symptoms, entry, "Symptoms"),        
                ]
              )
            );
  }

  Text gridKey(key) {
    return Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            );
  }

  TextFormField gridValue(value, EntriesModel entry, key) {
    return TextFormField(
              decoration: InputDecoration(
                  hintText: value,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0))),
              onChanged:(value) => {
                if (key == "Title")
                  updatedValues["Title"] = value
                else if (key == "Category")
                  entry.category = value
                else if (key == "Duration")
                  entry.duration = int.parse(value)
                else if (key == "Symptoms")
                  entry.symptoms = value
              },
            );
  }
}