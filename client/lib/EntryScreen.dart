import 'package:client/expandable_fab.dart';
import 'package:client/seizure_log_form.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryState();
}

class _EntryState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: entriesFAB(context),
      ),
    );
  }
}
