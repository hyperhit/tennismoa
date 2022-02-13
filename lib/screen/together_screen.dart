import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tennismoa/widget/common_webview.dart';
import 'package:tennismoa/util/dot_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TogetherScreen extends StatefulWidget {
  const TogetherScreen({Key? key}) : super(key: key);

  @override
  _TogetherScreenState createState() => _TogetherScreenState();
}

class _TogetherScreenState extends State<TogetherScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(child: Text('네이버 테친찾기')),
    Tab(child: Text('밴드 테친찾기')),
    Tab(child: Text('네이버 중고라켓')),
    Tab(child: Text('밴드 중고라켓')),
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
          style:
              TextStyle(color: Colors.deepPurple, fontFamily: 'NanumSquare', fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontFamily: 'NanumSquare', fontWeight: FontWeight.bold, fontSize: 15),
            indicator: const DotIndicator(),
            indicatorWeight: 1,
            isScrollable: true,
            controller: _tabController,
            tabs: _tabs,
            onTap: (int index) {},
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildNFriend(), _buildBFriend(), _buildNUsed(), _buildBUsed()],
      ),
    );
  }

  Widget _buildNFriend() {
    const url = 'https://m.cafe.naver.com/ca-fe/homecookie';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildBFriend() {
    const url = 'https://band.us/band/57302810';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildNUsed() {
    const url = 'https://m.cafe.naver.com/ca-fe/joonggossada';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildBUsed() {
    const url = 'https://band.us/band/59013894';
    return const CommonWebView(siteUrl: url);
  }
}
