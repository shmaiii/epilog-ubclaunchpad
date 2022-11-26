import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DurationInput extends StatefulWidget {
  const DurationInput({
    Key? key,
    LocaleType? localeType,
    required this.label,
  }) : super(key: key);

  final LocaleType? localeType = LocaleType.en;
  final String label;

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  DateTime _currentDuration = DateTime.now();

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              TextButton(
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        showSecondsColumn: false,
                        onConfirm: (date) =>
                            {setState(() => _currentDuration = date)},
                        currentTime: _currentDuration,
                        locale: widget.localeType ?? LocaleType.en);
                  },
                  child: Row(children: [
                    Text(
                      DateFormat('kk:mm').format(_currentDuration),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ]))
            ])));
  }
}
