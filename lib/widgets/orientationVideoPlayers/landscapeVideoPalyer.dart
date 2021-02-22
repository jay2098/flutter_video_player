import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/main.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/videoPlayerFullscreenWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class LandScapeVideoPlayer extends StatefulWidget {
  @override
  _LandScapeVideoPlayerState createState() => _LandScapeVideoPlayerState();
}

class _LandScapeVideoPlayerState extends State<LandScapeVideoPlayer> {
  VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(urlPortraitVideo)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => controller.play());

    setLandscape();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    setAllOrientation();
    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  Future setAllOrientation() async {
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerFullScreenWidget(controller: controller,);
  }
}
