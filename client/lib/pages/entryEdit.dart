import 'package:flutter/material.dart';

import '../model/entries.dart';

class entryEdit extends StatelessWidget {
  EntriesModel entry;
  entryEdit({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(),
          body: EntryEditForm(entry: entry),
        ),
      ),
    );
  }
}

class EntryEditForm extends StatefulWidget {
  EntriesModel entry;
  EntryEditForm({super.key, required this.entry});

  @override
  State<EntryEditForm> createState() => _EntryEditFormState(entry: entry);
}

class _EntryEditFormState extends State<EntryEditForm> {
  EntriesModel entry;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _EntryEditFormState({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
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
                  _FormTextInput(
                    label: "Title",
                    hintText: entry.title,
                  ),
                  _FormTextInput(
                    label: "Duration",
                    hintText: "${entry.duration} minutes",
                  ),
                  _FormTextInput(
                    label: "Category",
                    hintText: entry.category,
                  ),
                  _FormTextInput(
                    label: "Symptoms",
                    hintText: entry.symptoms,
                  ),
                  Stack(
                      alignment: Alignment.bottomRight,
                      clipBehavior: Clip.none,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ])
                ])));
  }
}

@immutable
class _FormTextInput extends StatelessWidget {
  const _FormTextInput({
    required this.label,
    required this.hintText,
  });

  final String label;
  final String hintText;
  final double itemWidth = 9;
  final double itemHeight = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: 
        //Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded (
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            shrinkWrap: true,
            children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: hintText,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 4.0))),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )
            
            ]
          )
          )
    );
        // ]));
  }
}