import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatefulWidget {
  DateTimeInput({
    Key? key,
    LocaleType? localeType,
    Function? onChanged,
    DateTime? minTime,
    DateTime? maxTime,
    required this.label,
    required this.storage,
  }) : super(key: key);

  final String label;
  final LocaleType? localeType = LocaleType.en;
  final Function? onChanged = null;
  final FlutterSecureStorage storage;

  final DateTime? minTime = DateTime(2020, 1, 1);
  final DateTime? maxTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  DateTime _selectedTime = DateTime.now();
  void updateTime(DateTime date) {
    setState(() {
      _selectedTime = date;
      String encoded = _selectedTime.toString();
      widget.storage.write(key: EntryFields.datetime, value: encoded);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVal();
  }

  _loadVal() async {
    String? encoded = await widget.storage.read(key: EntryFields.datetime);
    setState(() {
      if (encoded != null) {
        _selectedTime = DateTime.parse(encoded);
      }
    });
  }

  static const double inputFontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.label,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: inputFontSize),
      ),
      Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.black),
            ),
          ),
          child: TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: widget.minTime,
                    maxTime: widget.maxTime,
                    onConfirm: (date) => updateTime(date),
                    currentTime: _selectedTime,
                    locale: widget.localeType ?? LocaleType.en);
              },
              child: Row(children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(_selectedTime),
                  style: const TextStyle(
                      color: Colors.black, fontSize: inputFontSize),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR24_MINUTE)
                            .format(_selectedTime),
                        style: const TextStyle(
                            color: Colors.black, fontSize: inputFontSize),
                      ),
                    ],
                  ),
                )
              ]))),
    ]);
  }
}
