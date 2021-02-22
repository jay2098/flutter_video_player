import 'package:flutter/material.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/videoPlayerFullscreenWidget.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';

class PortraitVideoPlayer extends StatefulWidget {
  @override
  _PortraitVideoPlayerState createState() => _PortraitVideoPlayerState();
}

class _PortraitVideoPlayerState extends State<PortraitVideoPlayer> {
  VideoPlayerController portraitController;

  @override
  void initState() {
    super.initState();

    portraitController = VideoPlayerController.network(urlPortraitVideo)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => portraitController.play());
  }

  @override
  void dispose() {
    portraitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => VideoPlayerFullScreenWidget(controller: portraitController);
}
