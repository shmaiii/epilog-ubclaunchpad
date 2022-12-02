import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';

class Symptoms extends StatelessWidget {
  const Symptoms({
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
            children: const <Widget>[
              FormTextInput(
                label: "Did you experience any before effects?",
                hintText: "Before effects",
              ),
              FormTextInput(
                label: "Did you experience any after effects?",
                hintText: "After effects",
              ),
              FormTextInput(
                label: "Did you experience any symptoms after the seizure?",
                hintText: "Symptoms",
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
