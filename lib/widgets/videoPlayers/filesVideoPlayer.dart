import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/widgets/other/FloatingActionButtonWidget.dart';
import 'package:flutter_video_player/widgets/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class FilesVideoPlayer extends StatefulWidget {
  @override
  _FilesVideoPlayerState createState() => _FilesVideoPlayerState();
}

class _FilesVideoPlayerState extends State<FilesVideoPlayer> {
  File file;
  VideoPlayerController fileController;

  @override
  void initState() {
    super.initState();
    if (file != null && file.existsSync()) {
      fileController = VideoPlayerController.file(file)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => fileController.play());
    }
  }

  @override
  void dispose() {
    super.dispose();
    fileController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideoPlayerWidget(controller: fileController),
          buildAddButton(),
        ],
      ),
    );
  }

  Widget buildAddButton() {
    return Container(
      padding: EdgeInsets.all(32),
      child: FloatingActionButtonWidget(
        onPressed: () async {
          final file = await pickVideoFile();
          if (file == null) return;

          fileController = VideoPlayerController.file(file)
            ..addListener(() => setState(() {}))
            ..setLooping(true)
            ..initialize().then((_) {
              fileController.play();
              setState(() {});
            });
        },
      ),
    );
  }

  Future<File> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;

    return File(result.files.single.path);
  }
}
