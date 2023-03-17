import 'package:client/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

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
  Map<String, bool> checkUpData = {};

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    String? checkUpString = await widget.storage.read(key: 'check_ups');
    if (checkUpString != null) {
      Map<String, dynamic> prefs = json.decode(checkUpString);
      setState(() {
        checkUpData = {
          'missed_medicine': prefs['missed_medicine'] ?? false,
          'sufficient_sleep': prefs['sufficient_sleep'] ?? false,
          'high_stress': prefs['high_stress'] ?? false,
          'stimulating_environment': prefs['stimulating_environment'] ?? false,
        };
      });
    }
  }

  void _saveCheckupData() async {
    await widget.storage.write(
      key: 'check_ups',
      value: json.encode(checkUpData),
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
                  value: checkUpData['missed_medicine'] ?? false,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkUpData['missed_medicine'] = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text('Have you had sufficient sleep?'),
                  value: checkUpData['sufficient_sleep'] ?? false,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkUpData['sufficient_sleep'] = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text('Have your stress levels been high?'),
                  value: checkUpData['high_stress'] ?? false,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkUpData['high_stress'] = newValue;
                    });
                    _saveCheckupData();
                  },
                ),
                SwitchListTile(
                  title: const Text(
                      'Have you been in a highly stimulating environment?'),
                  value: checkUpData['stimulating_environment'] ?? false,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkUpData['stimulating_environment'] = newValue;
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