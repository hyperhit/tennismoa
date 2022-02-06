import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tennismoa/temp/common_webview.org.dart';
import 'package:tennismoa/util/dot_indicator.dart';
import 'package:tennismoa/widget/video_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(child: Text('모아보기')),
    Tab(child: Text('이형택TV')),
    Tab(child: Text('하늘쌤')),
    Tab(child: Text('테니스한쌤')),
    Tab(child: Text('아테TV')),
    Tab(child: Text('우리동네윔블던')),
    Tab(child: Text('포티러브')),
    Tab(child: Text('KATA')),
    Tab(child: Text('KATO')),
    Tab(child: Text('몽키테니스')),
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
          '테니스 동영상',
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
          _buildSeeAll(),
          _buildLeeTv(),
          _buildSkyTennis(),
          _buildHan(),
          _buildAteTv(),
          _buildWoori(),
          _buildForty(),
          _buildKataTv(),
          _buildKataoTv(),
          _buildMonkey(),
        ],
      ),
    );
  }

  Widget _buildSeeAll() {
    //모아보기
    const String url = 'https://www.youtube.com/results?search_query=%ED%85%8C%EB%8B%88%EC%8A%A4';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildLeeTv() {
    //이형택
    const String url = 'https://youtube.com/user/hyungtaik76/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildSkyTennis() {
    //하늘쌤
    const String url =
        'https://youtube.com/c/RTPTennis%ED%95%98%EB%8A%98%EC%8C%A4%ED%85%8C%EB%8B%88%EC%8A%A4%EA%BF%80%ED%8C%81/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildMonkey() {
    //몽키
    const String url = 'https://www.youtube.com/channel/UCVY9b2GyPBOAxvdTAf_I_NA/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildHan() {
    //한쌤
    const String url = 'https://youtube.com/c/%ED%85%8C%EB%8B%88%EC%8A%A4%ED%95%9C%EC%8C%A4/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildAteTv() {
    //아테티비
    const String url = 'https://youtube.com/c/ATEtv/vidoes';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildWoori() {
    //우리동네윔블던
    const String url = 'https://youtube.com/channel/UCN9b_OZGIw37E6G5pETk1pg/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildForty() {
    //포티러브
    const String url = 'https://youtube.com/c/%ED%8F%AC%ED%8B%B0%EB%9F%AC%EB%B8%8C/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildKataTv() {
    //카타
    const String url = 'https://youtube.com/channel/UCOhApwd9XBkeYzsl7fsE2FA/videos';
    return const VideoWebView(siteUrl: url);
  }

  Widget _buildKataoTv() {
    //카토
    const String url = 'https://youtube.com/c/katotennis/videos';
    return const VideoWebView(siteUrl: url);
  }
}
