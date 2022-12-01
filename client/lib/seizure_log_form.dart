import 'package:client/duration_picker.dart';
import 'package:flutter/material.dart';
import 'date_time_input.dart';

class SeizureLogPage extends StatelessWidget {
  const SeizureLogPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Scaffold(
          body: SeizureLogForm(),
        ),
      ),
    );
  }
}

class SeizureLogForm extends StatefulWidget {
  const SeizureLogForm({super.key});

  @override
  State<SeizureLogForm> createState() => _SeizureLogFormState();
}

class _SeizureLogFormState extends State<SeizureLogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: BackButton(),
          ),
        ),
        Column(children: [
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'New Seizure Log',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  const _FormTextInput(
                    label: "What would you like to name this entry?",
                    hintText: "New Title",
                  ),
                  DateTimeInput(
                    label: "When did this seizure occur?",
                  ),
                  const DurationPicker(
                    label: "How long did the seizure last?",
                  ),
                  const _FormTextInput(
                    label: "What were you doing at the time of the seizure?",
                    hintText: "Activity",
                  ),
                ],
              ),
            ),
          ),
        ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Next >',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ),
      ]),
    );
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
