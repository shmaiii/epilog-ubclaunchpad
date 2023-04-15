import 'package:client/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.storage,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final FlutterSecureStorage storage;

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAdditionalNotes();
  }

  void _loadAdditionalNotes() async {
    String? notes = await widget.storage.read(key: 'additional_info');
    if (notes != null) {
      _textController.text = notes;
    }
  }

  void _saveAdditionalNotes(String notes) async {
    await widget.storage.write(key: 'additional_info', value: notes);
  }

  OutlineInputBorder textBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: widget._formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32.0),
              const Text(
                'Any additional notes?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: _textController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: textBorder,
                  focusedBorder: textBorder,
                  hintText: 'Additional notes',
                  fillColor: const Color(0xFFDBC8EE),
                  filled: true,
                ),
                onChanged: (value) {
                  _saveAdditionalNotes(value);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  String get additionalNotes => _textController.text;
}
