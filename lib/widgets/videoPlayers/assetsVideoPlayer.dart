import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../videoPlayerWidget.dart';

class AssetsVideoPlayer extends StatefulWidget {
  @override
  _AssetsVideoPlayerState createState() => _AssetsVideoPlayerState();
}

class _AssetsVideoPlayerState extends State<AssetsVideoPlayer> {
  final asset = 'assets/video.mp4';
  VideoPlayerController assetController;

  @override
  void initState() {
    super.initState();
    assetController = VideoPlayerController.asset(asset)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => assetController.play());
  }

  @override
  void dispose() {
    super.dispose();
    assetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = assetController.value.volume == 0;
    return Column(
      children: [
        VideoPlayerWidget(
          controller: assetController,
        ),
        const SizedBox(
          height: 32,
        ),
        if (assetController != null && assetController.value.initialized)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(
                isMuted ? Icons.volume_mute : Icons.volume_up,
              ),
              onPressed: () => assetController.setVolume(isMuted ? 1 : 0),
            ),
          )
      ],
    );
  }
}
