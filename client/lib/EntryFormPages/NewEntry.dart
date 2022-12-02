import 'package:client/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';

class NewEntry extends StatelessWidget {
  const NewEntry({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

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
              const FormTextInput(
                label: "What would you like to name this entry?",
                hintText: "New Title",
              ),
              DateTimeInput(
                label: "When did this seizure occur?",
              ),
              const DurationPicker(
                label: "How long did the seizure last?",
              ),
              const FormTextInput(
                label: "What were you doing at the time of the seizure?",
                hintText: "Activity",
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
