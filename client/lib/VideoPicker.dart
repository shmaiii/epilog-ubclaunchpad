// a video picker page to see what the link looks like when user picks a video from the local gallery

import 'package:flutter/material.dart';

class VideoPicker extends StatefulWidget {
  final String filePath;
  const VideoPicker({Key? key, required this.filePath}): super(key: key);

@override
  State<VideoPicker> createState() => _VideoPickerState();
}

class _VideoPickerState extends State<VideoPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker Example"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                    "Pick Image from Gallery",
                  style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold
                  )
                ),
                onPressed: () {
                }
            ),
            MaterialButton(
                color: Colors.blue,
                child: const Text(
                    "Pick Image from Camera",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                }
            ),
          ],
        ),
      )
    );
  }
}