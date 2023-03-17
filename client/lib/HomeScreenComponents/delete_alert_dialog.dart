export 'delete_alert_dialog.dart';
import 'package:flutter/material.dart';

showDeleteAlertDialog(
    BuildContext context, String id, Function deleteReminder) {
  Widget noButton = TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: const Color(0XFFEEEEEE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: const Size(95, 38),
      elevation: 10,
      shadowColor: Colors.grey,
    ),
    child: const Text(
      "No",
      style: TextStyle(
        fontSize: 18.0,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget yesButton = TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: const Color(0XFFEEEEEE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: const Size(95, 38),
      elevation: 10,
      shadowColor: Colors.grey,
    ),
    child: const Text(
      "Yes",
      style: TextStyle(
        fontSize: 18.0,
      ),
    ),
    onPressed: () {
      deleteReminder(id);
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
      title: const Text("Delete medicine?",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center),
      actions: [
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                yesButton,
                const SizedBox(width: 10),
                noButton,
              ],
            ))
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
