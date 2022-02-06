import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tennismoa/temp/hide_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'screen/tournament_screen.dart';
import 'screen/video_screen.dart';
import 'screen/news_screen.dart';
import 'screen/friend_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tennismoa',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: TennisMoa(),
      routes: {
        '/tournament': (context) => TournamentScreen(),
        '/video': (context) => VideoScreen(),
        '/news': (context) => NewsScreen(),
        '/friend': (context) => FriendScreen(),
      },
    );
  }
}

class TennisMoa extends StatefulWidget {
  const TennisMoa({Key? key}) : super(key: key);

  @override
  _TennisMoaState createState() => _TennisMoaState();
}

class _TennisMoaState extends State<TennisMoa> {
  final controller = ScrollController();
  int _selectedIndex = 0;

  final List _screens = const [TournamentScreen(), VideoScreen(), NewsScreen(), FriendScreen()];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void _onTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/video');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        //unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 9,
        unselectedFontSize: 9,
        backgroundColor: Colors.white,
        onTap: _onTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: '대회'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_display_outlined), label: '동영상'),
          BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), label: '뉴스'),
          BottomNavigationBarItem(icon: Icon(Icons.person_search_outlined), label: '친구찾기'),
        ],
      ),
    );
  }
}
