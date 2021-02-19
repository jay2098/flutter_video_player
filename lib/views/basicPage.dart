import 'package:flutter/material.dart';
import '../widgets/videoPlayers/assetsVideoPlayer.dart';
import '../widgets/videoPlayers/filesVideoPlayer.dart';
import '../widgets/videoPlayers/networkVideoPlayer.dart';
import '../widgets/other/tabBarWidget.dart';

class BasicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      tabs: [
        Tab(icon: Icon(Icons.file_copy), text: 'Asset'),
        Tab(icon: Icon(Icons.attach_file), text: 'File'),
        Tab(icon: Icon(Icons.ondemand_video_outlined), text: 'Network'),
      ],
      children: [
        buildAssets(),
        buildFiles(),
        buildNetwork(),
      ],
    );
  }

  Widget buildAssets() => AssetsVideoPlayer();

  Widget buildFiles() => FilesVideoPlayer();

  Widget buildNetwork() => NetworkVideoPlayer();
}
