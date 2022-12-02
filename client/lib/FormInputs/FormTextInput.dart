import 'package:flutter/material.dart';

@immutable
class FormTextInput extends StatelessWidget {
  const FormTextInput({
    super.key,
    required this.label,
    required this.hintText,
  });

  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          TextFormField(
            maxLength: 50,
            decoration: InputDecoration(
                hintText: hintText,
                helperText: " ",
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
        ]));
  }
}
