import 'package:client/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toggle_switch/toggle_switch.dart';

// bool _missedMedicine = false;
// bool _sufficientSleep = false;
// bool _highStress = false;
// bool _stimulatingEnvironment = false;

// class Checkup extends StatefulWidget {
//   const Checkup({
//     Key? key,
//     required GlobalKey<FormState> formKey,
//     required this.storage,
//   })  : _formKey = formKey,
//         super(key: key);

//   final GlobalKey<FormState> _formKey;
//   final FlutterSecureStorage storage;

//   @override
//   _CheckupState createState() => _CheckupState();
// }

// class _CheckupState extends State<Checkup> {
//   Map<String, bool> checkUpData = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadCheckupData();
//   }

//   void _loadCheckupData() async {
//     final prefs = await widget.storage.readAll();
//     setState(() {
//       checkUpData = {
//         'missed_medicine': prefs['missed_medicine'] == 'true',
//         'sufficient_sleep': prefs['sufficient_sleep'] == 'true',
//         'high_stress': prefs['high_stress'] == 'true',
//         'stimulating_environment': prefs['stimulating_environment'] == 'true',
//       };
//     });
//   }

//   void _saveCheckupData() async {
//     await widget.storage.write(
//       key: 'check_ups',
//       value: checkUpData.toString(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Form(
//           key: widget._formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'All of the following questions refer to the last 24 hours',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SwitchListTile(
//                   title: const Text('Have you missed taking medicine?'),
//                   value: checkUpData['missed_medicine'] ?? _missedMedicine,
//                   onChanged: (bool newValue) {
//                     setState(() {
//                       checkUpData['missed_medicine'] = newValue;
//                     });
//                     _saveCheckupData();
//                   },
//                 ),
//                 SwitchListTile(
//                   title: const Text('Have you had sufficient sleep?'),
//                   value: checkUpData['sufficient_sleep'] ?? _sufficientSleep,
//                   onChanged: (bool newValue) {
//                     setState(() {
//                       checkUpData['sufficient_sleep'] = newValue;
//                     });
//                     _saveCheckupData();
//                   },
//                 ),
//                 SwitchListTile(
//                   title: const Text('Have your stress levels been high?'),
//                   value: checkUpData['high_stress'] ?? _highStress,
//                   onChanged: (bool newValue) {
//                     setState(() {
//                       checkUpData['high_stress'] = newValue;
//                     });
//                     _saveCheckupData();
//                   },
//                 ),
//                 SwitchListTile(
//                   title: const Text(
//                       'Have you been in a highly stimulating environment?'),
//                   value: checkUpData['stimulating_environment'] ?? _stimulatingEnvironment,
//                   onChanged: (bool newValue) {
//                     setState(() {
//                       checkUpData['stimulating_environment'] = newValue;
//                     });
//                     _saveCheckupData();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

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
    final prefs = await widget.storage.readAll();
    String? checkUpString = await widget.storage.read(key: 'check_ups');
    setState(() {
      checkUpData = {
        'missed_medicine': prefs['missed_medicine'] == 'true',
        'sufficient_sleep': prefs['sufficient_sleep'] == 'true',
        'high_stress': prefs['high_stress'] == 'true',
        'stimulating_environment': prefs['stimulating_environment'] == 'true',
      };
    });
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
        initialLabelIndex: 0,
        totalSwitches: 2,
        labels: const ['Yes', 'No'],
        onToggle: (index) {
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
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
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
