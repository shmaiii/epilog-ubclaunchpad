import 'package:client/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/service/entryManager.dart';

class NewEntry extends StatelessWidget {
  const NewEntry({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.storage,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final FlutterSecureStorage storage;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormTextInput(
                label: "What would you like to name this entry?",
                hintText: "New Title",
                storage: storage,
                id: EntryFields.name,
              ),
              DateTimeInput(
                label: "When did this seizure occur?",
              ),
              DurationPicker(
                label: "How long did the seizure last?",
                id: EntryFields.duration,
                storage: storage,
              ),
              FormTextInput(
                  label: "What were you doing at the time of the seizure?",
                  hintText: "Activity",
                  storage: storage,
                  id: EntryFields.activity),
            ],
          ),
        ),
      ),
    ]);
  }
}
