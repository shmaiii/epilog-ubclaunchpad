import 'package:flutter/material.dart';

class TakeToggleButton extends StatefulWidget {
  final String id;
  final bool take;
  final Function(String, bool) updateReminderTake;

  const TakeToggleButton(
      {super.key,
      required this.id,
      required this.take,
      required this.updateReminderTake});

  @override
  State<TakeToggleButton> createState() => _TakeToggleButtonState();
}

class _TakeToggleButtonState extends State<TakeToggleButton> {
  void _toggleButtonText() {
    setState(() {
      widget.updateReminderTake(widget.id, !widget.take);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 83.0,
        height: 34.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blue,
        ),
        child: TextButton(
          onPressed: _toggleButtonText,
          style: widget.take
              ? TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 156, 94, 167),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))
              : TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
          child: widget.take
              ? const Text('UNTAKE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
              : const Text('TAKE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ));
  }
}
