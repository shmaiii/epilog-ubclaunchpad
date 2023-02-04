//import 'dart:html';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Loading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Welcome to Loading'),
        ),
        body: const Center(
          child: Text('Hello Loading'),
        )
    );
  }
}