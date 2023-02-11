import 'main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io; 
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

class RecordingPage extends StatelessWidget {
  const RecordingPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecordScreen(),
    );
  }
}

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}): super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  late CameraController _cameraController;
  bool _isLoading = true;
  bool _isRecording = false;

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _initCamera();  
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

  // @override
  // void initState() {
  //   super.initState();

  //   _videoPlayerController = VideoPlayerController.file(io.File(widget.filePath));
  //   _initializeVideo = _videoPlayerController.initialize();
  //   _videoPlayerController.play();
  // }


  @override 
  void dispose(){
    _videoPlayerController.dispose();
    super.dispose();
  }
    Future _initVideoPlayer() async {
      _videoPlayerController = VideoPlayerController.file(io.File(widget.filePath));
      await _videoPlayerController.initialize();
      await _videoPlayerController.setLooping(true); // video will loop
      await _videoPlayerController.play();
    }

  void _saveVideo() async {
    await GallerySaver.saveVideo(widget.filePath);
    print('video saved');
    dispose(); // later changed to link to entry page or sth
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print("icon pressed");
              _saveVideo();
              }
            )],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder:(context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        }
      )
    );
  }
}
