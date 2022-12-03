

import 'package:flutter/material.dart';

class Symptoms extends StatelessWidget {
  const Symptoms({super.key});
  @override
Widget build(BuildContext context) {
    return Form(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Symptoms',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  const _FormTextInput(
                    label: "Did you have any before effects?",
                    hintText: "Before effects",
                  ),
                  const _FormTextInput(
                    label: "Did you have any after effects?",
                    hintText: "After effects",
                  ),
                  const _FormTextInput(
                    label: "Did you have any symptoms during the seizure?",
                    hintText: "Symptoms",
                  ),
                  Stack(
                      alignment: Alignment.bottomRight,
                      clipBehavior: Clip.none)
                ])));
    
  }
  
}


// ignore: must_be_immutable
class _FormTextInput extends StatelessWidget {
  final String label;
  final String hintText;

  const _FormTextInput({
    required this.label,
    required this.hintText,
  });
  
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    throw UnimplementedError();
  }
}