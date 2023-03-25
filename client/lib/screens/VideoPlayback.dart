import '../main.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io' as io; 
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlaybackPage extends StatefulWidget {
  final io.File file;
  const VideoPlaybackPage({Key? key, required this.file}): super(key: key);

  @override
  State<VideoPlaybackPage> createState() => _VideoPlaybackPageState();
}

class _VideoPlaybackPageState extends State<VideoPlaybackPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.file(widget.file);
    _initializeVideo = _videoPlayerController.initialize();
  }

  @override 
  void dispose(){
    _videoPlayerController.dispose();
    super.dispose();
  }
    // Future _initVideoPlayer() async {
    //   print('playing back');
    //   _videoPlayerController = VideoPlayerController.file(widget.file);
    //   await _videoPlayerController.initialize();
    //   await _videoPlayerController.setLooping(true); // video will loop
    //   await _videoPlayerController.play();
    // }

    void _stopPlay() {
      
              if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              _videoPlayerController.play();
            }
          
    }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playing back the Video"),
      ),
      
      // extendBodyBehindAppBar: true,
      body: Stack(
        children: [FutureBuilder(
        future: _initializeVideo,
        builder:(context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
              );
          }
        }
      ),
      Positioned(
        bottom: 0,
        width: MediaQuery.of(context).size.width,
        child: VideoProgressIndicator(
          _videoPlayerController,
          allowScrubbing: true,)
      ),
     
      Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_videoPlayerController.value.isPlaying) {
                _videoPlayerController.pause();
              } else {
                _videoPlayerController.play();
              }
            });
          },
          child: Icon(
            _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
          )
        )
      ),
    ]
        
    )
    );
  }
}
