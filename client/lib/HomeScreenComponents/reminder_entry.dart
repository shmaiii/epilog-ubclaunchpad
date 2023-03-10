
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'take_toggle_button.dart';

const List<String> optionText = <String>[
  "Reschedule",
  "Delete",
];

// Widget for each entry in the list of reminders
class ReminderEntry extends StatelessWidget {
  final String id;
  final bool take;
  final String title;
  final String type;
  final String notes;
  final Function(BuildContext, String, void Function(String))
      showDeleteAlertDialog;
  final Function(String) deleteReminder;
  final Function(String, String) rescheduleReminder;
  final Function(String, bool) updateReminderTake;

  const ReminderEntry(
      {super.key,
      required this.id,
      required this.take,
      required this.title,
      required this.type,
      required this.notes,
      required this.showDeleteAlertDialog,
      required this.deleteReminder,
      required this.rescheduleReminder,
      required this.updateReminderTake});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                  // textAlign: TextAlign.left,
                ),
                backgroundColor: const Color(0xfff3f3f3),
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: PopupMenuButton<int>(
                      constraints:
                          const BoxConstraints.expand(width: 140, height: 90),
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onSelected: (value) {
                        if (value == 0) {
                          // Perform action on click on Reschedule
                          DatePicker.showDateTimePicker(context,
                              theme: const DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (dateTime) {
                            rescheduleReminder(id, dateTime.toIso8601String());
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        }
                        if (value == 1) {
                          // Perform action on click on Delete
                          showDeleteAlertDialog(context, id, deleteReminder);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 0,
                            height: 30,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(optionText[0]))),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                            value: 1,
                            height: 20,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(optionText[1]))),
                      ],
                    ),
                  ),
                ],
              ),
              body: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            type,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            notes,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: const Alignment(-1, 1),
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TakeToggleButton(
                          id: id,
                          take: take,
                          updateReminderTake: updateReminderTake,
                        )),
                  ),
                ],
              ),
              backgroundColor: const Color(0xfff3f3f3))),
    );
  }
}
