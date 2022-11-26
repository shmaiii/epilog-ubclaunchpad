import 'package:flutter/material.dart';

import 'main.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordState();
}

class _RecordState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Record',
          style: demotextstyle,
        ),
      ),
    );
  }
}
