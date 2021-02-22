import 'package:flutter/material.dart';
import 'package:flutter_video_player/main.dart';
import 'package:flutter_video_player/widgets/other/FloatingActionButtonWidget.dart';
import 'package:flutter_video_player/widgets/other/textFieldWidget.dart';
import 'package:flutter_video_player/widgets/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  @override
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  final textController = TextEditingController(text: urlLandscapeVideo);
  VideoPlayerController networkController;

  @override
  void initState() {
    super.initState();
    networkController = VideoPlayerController.network(textController.text)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => networkController.play());
  }

  @override
  void dispose() {
    networkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          VideoPlayerWidget(controller: networkController),
          buildTextField(),
        ],
      ),
    );
  }

  Widget buildTextField() => Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: TextFieldWidget(controller: textController, hintText: 'Enter Video Url'),
            ),
            const SizedBox(
              width: 12,
            ),
            FloatingActionButtonWidget(onPressed: () {
              if (textController.text.trim().isEmpty) return;
            }),
          ],
        ),
      );
}
