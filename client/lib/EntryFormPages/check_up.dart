import 'package:client/duration_picker.dart';
import 'package:client/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


bool _missedMedicine = false;
bool _sufficientSleep = false;
bool _highStress = false;
bool _stimulatingEnvironment = false;

class Checkup extends StatefulWidget {
  const Checkup({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.storage,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final FlutterSecureStorage storage;

  @override
  _CheckupState createState() => _CheckupState();
}

class _CheckupState extends State<Checkup> {

  @override
  void initState() {
    super.initState();
    _loadCheckupData();
  }

  void _loadCheckupData() async {
    final prefs = await widget.storage.readAll();
    setState(() {
      _missedMedicine = prefs['missed_medicine'] == 'true';
      _sufficientSleep = prefs['sufficient_sleep'] == 'true';
      _highStress = prefs['high_stress'] == 'true';
      _stimulatingEnvironment = prefs['stimulating_environment'] == 'true';
    });
  }

  void _saveCheckupData() async {
    await widget.storage.write(
      key: 'missed_medicine',
      value: _missedMedicine.toString(),
    );
    await widget.storage.write(
      key: 'sufficient_sleep',
      value: _sufficientSleep.toString(),
    );
    await widget.storage.write(
      key: 'high_stress',
      value: _highStress.toString(),
    );
    await widget.storage.write(
      key: 'stimulating_environment',
      value: _stimulatingEnvironment.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: widget._formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All of the following questions refer to the last 24 hours',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SwitchListTile(
                  title: const Text('Have you missed taking medicine?'),
                  value: _missedMedicine,
                  onChanged: (bool newValue) {
                    setState(() {
                      _missedMedicine = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text('Have you had sufficient sleep?'),
                  value: _sufficientSleep,
                  onChanged: (bool newValue) {
                    setState(() {
                      _sufficientSleep = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text('Have your stress levels been high?'),
                  value: _highStress,
                  onChanged: (bool newValue) {
                    setState(() {
                      _highStress = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text(
                      'Have you been in a highly stimulating environment?'),
                  value: _stimulatingEnvironment,
                  onChanged: (bool newValue) {
                    setState(() {
                      _stimulatingEnvironment = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
