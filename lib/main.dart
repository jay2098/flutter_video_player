import 'package:flutter/material.dart';

import 'views/basicPage.dart';
import 'views/orientationPage.dart';

final urlLandscapeVideo = 'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4';
final urlPortraitVideo = 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
final urlYoutubeVideo = 'https://youtube.com/watch?v=HSAa9yi0OMA';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video Player',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.dark(),
        ),
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: pages(),
    );
  }

  Widget pages() {
    switch (index) {
      case 0:
        return BasicsPage();
      case 1:
        return OrientationPage();
      default:
        return Container();
    }
  }

  Widget bottomNavBar() {
    final style = TextStyle(color: Colors.white);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Text(
            'Video Player',
            style: style,
          ),
          label: 'Basics',
        ),
        BottomNavigationBarItem(
          icon: Text(
            'Video Player',
            style: style,
          ),
          label: 'Orientation',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }
}
