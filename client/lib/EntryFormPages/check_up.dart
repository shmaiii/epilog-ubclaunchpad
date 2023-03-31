import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toggle_switch/toggle_switch.dart';
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

  static const dataLabels = [
    'missed_medicine',
    'sufficient_sleep',
    'high_stress',
    'stimulating_environment'
  ];

  void _loadInitialData() async {
    String? checkUpString = await widget.storage.read(key: 'check_ups');
    dynamic checkUpObject = json.decode(checkUpString ?? "");

    for (int i = 0; i < 4; i++) {
      setState(() {
        checkUpData[dataLabels[i]] = checkUpObject[dataLabels[i]] ?? false;
      });
    }
  }

  void _saveCheckupData() async {
    await widget.storage.write(
      key: 'check_ups',
      value: json.encode(checkUpData),
    );
  }

  List<String> toggleQuestions = [
    "Have you missed taking medicine?",
    "Have you had sufficient sleep?",
    "Have your stress levels been high?",
    "Have you been in a highly stimulating environment?"
  ];

  List<Widget> getToggles() {
    List<Widget> toggles = [];

    for (int i = 0; i < toggleQuestions.length; i++) {
      String question = toggleQuestions[i];

      Widget title = Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
      );

      Flexible cont = Flexible(child: title);

      Widget toggle = ToggleSwitch(
        initialLabelIndex: (checkUpData[dataLabels[i]] ?? false) ? 1 : 0,
        totalSwitches: 2,
        labels: const ['No', 'Yes'],
        onToggle: (index) {
          checkUpData[dataLabels[i]] = index != null && index == 1;
          _saveCheckupData();
          print('switched to: $index');
        },
        inactiveBgColor: const Color(0xFFEBE3FD),
        activeBgColor: const [Color(0xFF6247AA)],
        minHeight: 60,
        fontSize: 20,
        cornerRadius: 4,
      );

      Widget box = const SizedBox(height: 40);

      Row row = Row(children: [cont, toggle]);
      toggles.add(row);
      toggles.add(box);
    }
    return toggles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: widget._formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "All of the following questions refer to the past 24 hours",
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 30),
                  ...getToggles()
                ]),
          ),
        ),
      ],
    );
  }
}
