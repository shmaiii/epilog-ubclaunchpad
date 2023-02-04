import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Symptoms extends StatelessWidget {
  const Symptoms({
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
                label: "Did you experience any before effects?",
                hintText: "Before effects",
                storage: storage,
                id: "before_effects",
              ),
              FormTextInput(
                label: "Did you experience any after effects?",
                hintText: "After effects",
                storage: storage,
                id: "after_effects",
              ),
              FormTextInput(
                label: "Did you experience any symptoms after the seizure?",
                hintText: "Symptoms",
                storage: storage,
                id: "symptoms",
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
