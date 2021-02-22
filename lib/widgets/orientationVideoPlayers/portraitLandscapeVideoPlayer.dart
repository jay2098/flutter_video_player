import 'package:flutter/material.dart';
import 'package:flutter_video_player/main.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/videoPlayerBothWidget.dart';
import 'package:video_player/video_player.dart';

class PortraitAndLandscapeVideoPlayer extends StatefulWidget {
  @override
  _PortraitAndLandscapeVideoPlayerState createState() => _PortraitAndLandscapeVideoPlayerState();
}

class _PortraitAndLandscapeVideoPlayerState extends State<PortraitAndLandscapeVideoPlayer> {
  VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(urlPortraitVideo)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: VideoPlayerBothWidget(
        controller: controller,
      ),
    );
  }
}
