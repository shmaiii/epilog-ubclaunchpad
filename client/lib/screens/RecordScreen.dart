import '../main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io; 
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:content_resolver/content_resolver.dart';
import 'VideoPlayback.dart';

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
  late List <CameraDescription> _availableCameras;

  _getAvailableCameras() async {
    _availableCameras = await availableCameras();
    _initCamera(_availableCameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front));  
    }

  _initCamera(CameraDescription description) async {
    
    _cameraController = CameraController(description, ResolutionPreset.max, enableAudio: true);
    try {
      await _cameraController.initialize();
      setState(() {
        _isLoading = false;
      });
    } catch (e) { print(e); }
  }

  @override
  void initState(){
    super.initState();
    _getAvailableCameras();  
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

  void _switchCamera() {
    final lensDirection = _cameraController.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
     newDescription = _availableCameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = _availableCameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null){
      _initCamera(newDescription);
    } else {
      print('newDescription is null');
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
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(Icons.switch_camera),
                onPressed: () => _switchCamera(),
              )
            )
          ],
        ),
      );
     }
  }
}


//video testing page pop up right after recording
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

  // Future<io.File> convertUriToFile(String uriString) async {
  //   try {
  //     io.File file = await toFile(uriString);
  //     return file;
  //   } on UnsupportedError catch (e) {
  //     print (e.message);
  //   } on io.IOException catch (e) {
  //     print (e);
  //   } catch (e) {
  //     print(e);
  //   }
    
  //   return io.File('');
  // }

  void _saveVideo() async {
    print(widget.filePath);
    var result = await ImageGallerySaver.saveFile(widget.filePath);
    print (result);
    var path;
    if (result == null){
      path = '';
    } else {
      path = result['filePath'];
    }
    print('video saved');
    print('saved path: ' + path);
    //dispose(); // later changed to link to entry page or sth

    // content resolver take persistable permission ? working rn might need this if there's bug
    
    // try{
      io.File file = await toFile(path);
    // } on UnsupportedError catch (e) {
    //   print (e.message);
    // } on io.IOException catch (e) {
    //   print (e);
    // } catch (e) {
    //   print(e);
    // }

    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoPlaybackPage(file: file),
    );
      Navigator.push(context, route);
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
