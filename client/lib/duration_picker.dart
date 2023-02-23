import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    Key? key,
    LocaleType? localeType,
    required this.label,
    required this.storage,
    required this.id,
  }) : super(key: key);

  final LocaleType? localeType = LocaleType.en;
  final String label;
  final FlutterSecureStorage storage;
  final String id;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  int _currentMinutes = 0;
  int _currentSeconds = 0;

  void initState() {
    _loadValue();
  }

  _loadValue() async {
    String? durationStr = await widget.storage.read(key: widget.id);
    if (durationStr == null) return;
    setState(() {
      int duration = (int.parse(durationStr) / 1000).floor();
      int minutes = (duration / 60).floor();
      int seconds = (duration % 60);

      _currentMinutes = minutes;
      _currentSeconds = seconds;
    });
  }

  static const double inputFontSize = 20.0;

  static const int jump = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4, color: Colors.black),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                TextButton(
                    onPressed: () => Picker(
                        adapter: NumberPickerAdapter(data: [
                          const NumberPickerColumn(begin: 0, end: 59),
                          const NumberPickerColumn(
                              begin: 0, end: 59, jump: jump),
                        ]),
                        selecteds: [_currentMinutes, _currentSeconds],
                        delimiter: [
                          PickerDelimiter(
                              child: Container(
                            width: 30.0,
                            alignment: Alignment.center,
                            child: const Text(":",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ))
                        ],
                        hideHeader: true,
                        title: const Text("Please Select (mm:ss)"),
                        onConfirm: (Picker picker, List value) {
                          print(value.toString());
                          print(picker.getSelectedValues());
                          updateDuration(value);
                        }).showDialog(context),
                    child: Row(children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        _currentMinutes.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontSize: inputFontSize),
                      ),
                      const Text(
                        ' minutes',
                        style: TextStyle(
                            color: Colors.black, fontSize: inputFontSize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              _currentSeconds.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: inputFontSize),
                            ),
                            const Text(
                              ' seconds',
                              style: TextStyle(
                                  color: Colors.black, fontSize: inputFontSize),
                            ),
                          ],
                        ),
                      )
                    ])),
              ],
            )));
  }

  void updateDuration(List values) {
    setState(() {
      _currentMinutes = values[0];
      _currentSeconds = values[1] * jump;
      int durationMs = (_currentMinutes * 60 + _currentSeconds) * 1000;
      widget.storage.write(key: widget.id, value: durationMs.toString());
    });
    print(values[1]);
  }
}
