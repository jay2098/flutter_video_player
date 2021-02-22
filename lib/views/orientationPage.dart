import 'package:flutter/material.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/landscapeVideoPalyer.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/portraitLandscapeVideoPlayer.dart';
import 'package:flutter_video_player/widgets/orientationVideoPlayers/porttraitVideoPlayer.dart';
import 'package:flutter_video_player/widgets/other/tabBarWidget.dart';

class OrientationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      onTap: (index) {
        switch (index) {
          case 1:
            goToLandscape(context);
            break;
          case 2:
            goToPortraitAndLandscape(context);
            break;
        }
      },
      tabs: [
        Tab(icon: Icon(Icons.screen_lock_portrait), text: 'Portrait'),
        Tab(icon: Icon(Icons.screen_lock_landscape), text: 'Landscape'),
        Tab(icon: Icon(Icons.screen_rotation), text: 'Both'),
      ],
      children: [
        buildPortrait(),
        buildLandscape(context),
        buildPortraitAndLandscape(context),
      ],
    );
  }

  Widget buildPortrait() => PortraitVideoPlayer();

  Widget buildLandscape(BuildContext context) => buildButton(
        text: 'Back To Landscape',
        onClicked: () => goToLandscape(context),
      );

  Widget buildPortraitAndLandscape(BuildContext context) => buildButton(
        text: 'Back To Both',
        onClicked: () => goToPortraitAndLandscape(context),
      );

  Widget buildButton({@required String text, @required VoidCallback onClicked}) => Center(
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          onPressed: onClicked,
        ),
      );

  void goToLandscape(BuildContext context) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandScapeVideoPlayer()));

  void goToPortraitAndLandscape(BuildContext context) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PortraitAndLandscapeVideoPlayer()));
}
