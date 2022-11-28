import 'main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io; 
import 'package:camera/camera.dart';


class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});
  //const RecordingPage({super.key});
  final String title = "This is recording test page";

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  //List<String> videos = <String>[]; // store video file paths

  late CameraController _cameraController;
  bool _isLoading = true;
  bool _isRecording = false;

  // bool _imagePickerActive = false;
  // final ImagePicker _picker = ImagePicker();
  initCamera() async {
    final cameras = await availableCameras();
    // final firstCamera = cameras.first;
    final front = cameras.first;
    _cameraController = CameraController(front, ResolutionPreset.medium);
    _cameraController.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    initCamera();  
  }

  @override
  void dispose(){
    _cameraController.dispose();
    super.dispose();
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoPage(filePath: file.path),
    );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
  }

  // void takeVideo() async {
  //   if (_imagePickerActive) return;
  //   _imagePickerActive = true;

  //   final XFile ? videoFile = await _picker.pickVideo(source: ImageSource.camera);
  //   _imagePickerActive = false;

    

  //   if (videoFile == null) return;
  //   setState(() {
  //     videos.add(videoFile.path);
  //     print(videoFile.path);
  //   });

  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
  child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CameraPreview(_cameraController),
      Padding(
        padding: const EdgeInsets.all(25),
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(_isRecording ? Icons.stop : Icons.circle),
          onPressed: () => _recordVideo(),
        ),
      ),
    ],
  ),
);
    }
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //       ),
  //       body: Center(
  //         child: ListView.builder(
  //           padding: const EdgeInsets.all(8),
  //           itemCount: videos.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Card(
  //               child: Container(
  //                 padding: const EdgeInsets.all(8),
  //                 child: Center(child: Text(index.toString()))
  //               ),
  //             );
  //           },
  //         ),),
  //         floatingActionButton: FloatingActionButton(
  //           onPressed: takeVideo,
  //           tooltip: 'Take Video',
  //           child: const Icon(Icons.add),
  //           ),
  //   );
  }
}

class VideoPage extends StatefulWidget {
  final String filePath;
  const VideoPage({Key? key, required this.filePath}): super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends  State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.file(io.File(widget.filePath));
    _initializeVideo = _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  @override 
  void dispose(){
    _videoPlayerController.dispose();
    super.dispose();
  }
    // Future _initVideoPlayer() async {
    //   _videoPlayerController = VideoPlayerController.file(io.File(widget.filePath));
    //   await _videoPlayerController.initialize();
    //   await _videoPlayerController.play();
    // }

  @override 
  Widget build(BuildContext context){
    return Container(); //stub
  }
}
