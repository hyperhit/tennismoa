import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tennismoa/widget/common_webview.dart';
import 'package:tennismoa/util/dot_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(child: Text('테니스코리아')),
    Tab(child: Text('테니스피플')),
    Tab(child: Text('ATP Tour')),
    Tab(child: Text('호주오픈')),
    Tab(child: Text('프랑스오픈')),
    Tab(child: Text('윔블던')),
    Tab(child: Text('US오픈')),
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
          '테니스 뉴스',
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
        children: [
          _buildkorea(),
          _buildPeople(),
          _buildAtp(),
          _buildAusopen(),
          _buildFrance(),
          _buildWimbledon(),
          _buildUsopen(),
        ],
      ),
    );
  }

  Widget _buildkorea() {
    const url = 'https://m.tennis.co.kr/';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildPeople() {
    const url = 'http://www.tennispeople.kr/';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildAtp() {
    const url = 'http://atptour.com';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildAusopen() {
    const url = 'https://ausopen.com/';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildFrance() {
    const url = 'https://www.rolandgarros.com/en-us/';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildWimbledon() {
    const url = 'https://www.wimbledon.com/';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildUsopen() {
    const url = 'https://www.usopen.org/';
    return const CommonWebView(siteUrl: url);
  }
}
