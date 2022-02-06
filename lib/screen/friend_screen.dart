import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tennismoa/widget/common_webview.dart';
import 'package:tennismoa/util/dot_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(child: Text('네이버 테니스 친구찾기')),
    Tab(child: Text('밴드 테니스 친구찾기')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '테니스 함께해요',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicator: const DotIndicator(),
          indicatorWeight: 1,
          isScrollable: true,
          controller: _tabController,
          tabs: _tabs,
          onTap: (int index) {},
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNaver(),
          _buildBand(),
        ],
      ),
    );
  }

  Widget _buildNaver() {
    const url = 'https://m.cafe.naver.com/ca-fe/homecookie';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildBand() {
    const url = 'https://band.us/band/57302810';
    return const CommonWebView(siteUrl: url);
  }
}
