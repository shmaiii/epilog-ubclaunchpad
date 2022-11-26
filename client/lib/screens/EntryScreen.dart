import 'package:flutter/material.dart';

import '../main.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryState();
}

class _EntryState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Entry',
          style: demotextstyle,
        ),
      ),
    );
  }
}
