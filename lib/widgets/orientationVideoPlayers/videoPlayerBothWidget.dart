import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/widgets/advancedOverlayWidget.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerBothWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerBothWidget({Key key, this.controller}) : super(key: key);

  @override
  _VideoPlayerBothWidgetState createState() => _VideoPlayerBothWidgetState();
}

class _VideoPlayerBothWidgetState extends State<VideoPlayerBothWidget> {
  Orientation target;

  @override
  void initState() {
    NativeDeviceOrientationCommunicator().onOrientationChanged(useSensor: true).listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;

      final isLandscape =
          event == NativeDeviceOrientation.landscapeLeft /*|| event == NativeDeviceOrientation.landscapeRight*/;

      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
    super.initState();
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller != null && widget.controller.value.initialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          setOrientation(isPortrait);

          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.expand,
            children: [
              buildVideoPlayer(),
              Positioned.fill(
                child: AdvancedOverlayWidget(
                  controller: widget.controller,
                  onClickedFullScreen: () {
                    target = isPortrait ? Orientation.landscape : Orientation.portrait;

                    if (isPortrait) {
                      AutoOrientation.landscapeRightMode();
                    } else {
                      AutoOrientation.portraitUpMode();
                    }
                  },
                ),
              ),
            ],
          );
        },
      );

  Widget buildVideoPlayer() {
    final aspectRatio = widget.controller.value.aspectRatio;
    return buildFullScreen(
      child: AspectRatio(
        aspectRatio: widget.controller.value.aspectRatio,
        child: RotatedBox(
          quarterTurns: target == Orientation.landscape && aspectRatio < 1 ? -1 : 0,
          child: VideoPlayer(
            widget.controller,
          ),
        ),
      ),
    );
  }

  Widget buildFullScreen({
    @required Widget child,
  }) {
    final size = widget.controller.value.size;
    final width = size?.width ?? 0;
    final height = size?.height ?? 0;
    print(widget.controller.value.aspectRatio);

    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
