import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RecordingPage(),
    );
  }
}

class RecordingPage extends StatefulWidget {
  //const RecordingPage({super.key});
  String title = "This is recording test page";

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  List<String> videos = <String>[]; // store video file paths

  bool _imagePickerActive = false;
  final ImagePicker _picker = ImagePicker();

  void takeVideo() async {
    if (_imagePickerActive) return;
    _imagePickerActive = true;

    final XFile ? videoFile = await _picker.pickVideo(source: ImageSource.camera);
    _imagePickerActive = false;

    if (videoFile == null) return;
    setState(() {
      videos.add(videoFile.path);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        ),
        body: Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: videos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Center(child: Text(index.toString()))
                ),
              );
            },
          ),),
          floatingActionButton: FloatingActionButton(
            onPressed: takeVideo,
            tooltip: 'Take Video',
            child: const Icon(Icons.add),
            ),
    );
  }
}
