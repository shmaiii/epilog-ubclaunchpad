import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    Key? key,
    LocaleType? localeType,
    required this.label,
  }) : super(key: key);

  final LocaleType? localeType = LocaleType.en;
  final String label;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  int _currentMinutes = 0;
  int _currentSeconds = 0;

  static const double inputFontSize = 20.0;

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
                          const NumberPickerColumn(begin: 0, end: 59, jump: 5),
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
                        _currentMinutes.toString().padLeft(2, '0'),
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
      _currentSeconds = values[1];
    });
    print(values[1]);
  }
}
