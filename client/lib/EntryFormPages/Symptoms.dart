import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/service/entryManager.dart';

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
                label: "Did you have any before effects?",
                hintText: "Before effects",
                storage: storage,
                id: EntryFields.beforeEffects,
              ),
              FormTextInput(
                label: "Did you have any after effects?",
                hintText: "After effects",
                storage: storage,
                id: EntryFields.afterEffects,
              ),
              FormTextInput(
                label: "Did you have any symptoms during the seizure?",
                hintText: "Symptoms",
                storage: storage,
                id: EntryFields.symptoms,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
