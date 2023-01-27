import 'package:client/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoryType extends StatelessWidget {
  const CategoryType({
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
                label: "What category of seizure did this appear to be?",
                hintText: "Category",
                storage: storage,
                id: "category",
              ),
              FormTextInput(
                label: "What type of seizure did this appear to be?",
                hintText: "Type",
                storage: storage,
                id: "type",
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
