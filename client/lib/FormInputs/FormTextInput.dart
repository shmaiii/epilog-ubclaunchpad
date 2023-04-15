import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@immutable
class FormTextInput extends StatefulWidget {
  const FormTextInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.storage,
    required this.id,
  });

  final String label;
  final String hintText;
  final FlutterSecureStorage storage;

  final String id;

  @override
  State<FormTextInput> createState() => _FormTextInputState();
}

class _FormTextInputState extends State<FormTextInput> {
  @override
  void initState() {
    super.initState();
    _loadValues();
    _controller.addListener(() {
      String val = _controller.text;
      widget.storage.write(key: widget.id.toString(), value: val);
      setState(() {});
    });
  }

  _loadValues() async {
    _controller.text = await widget.storage.read(key: widget.id) ?? "";
    setState(() {});
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          TextFormField(
            controller: _controller,
            maxLength: 50,
            decoration: InputDecoration(
                hintText: widget.hintText,
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
            style: const TextStyle(fontSize: 17),
          )
        ]));
  }
}
