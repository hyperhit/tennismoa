import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tennismoa/util/dot_indicator.dart';
import 'package:tennismoa/widget/common_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key}) : super(key: key);

  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**/
      appBar: AppBar(
        title: const Text(
          '테니스 대회',
          style:
              TextStyle(color: Colors.deepPurple, fontFamily: 'NanumSquare', fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28),
          child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontFamily: 'NanumSquare', fontWeight: FontWeight.bold, fontSize: 15),
            indicator: const DotIndicator(),
            indicatorWeight: 1,
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(child: Text('KATA')),
              Tab(child: Text('KATO')),
              Tab(child: Text('KTA 생활체육')),
              Tab(child: Text('바볼랏언더독')),
              Tab(child: Text('월간테린이')),
            ],
            onTap: (int index) {},
          ),
        ),
      ),
      /*
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicator: const DotIndicator(),
          indicatorWeight: 1,
          isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(child: Text('KATA')),
            Tab(child: Text('KATO')),
            Tab(child: Text('KTA 생활체육')),
            Tab(child: Text('바볼랏언더독')),
            Tab(child: Text('월간테린이')),
          ],
          onTap: (int index) {},
        ),
      ),
      */
      /* appbar 없이 tabbar만 있는 UI
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        toolbarHeight: 45.0,
        elevation: 0.5,
        flexibleSpace: SafeArea(
          child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //indicator: const DotIndicator(),
            indicatorWeight: 2,
            indicatorColor: Colors.black,
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(child: Text('KATA')),
              Tab(child: Text('KATO')),
              Tab(child: Text('KTA 생활체육')),
              Tab(child: Text('바볼랏언더독')),
              Tab(child: Text('월간테린이')),
            ],
            onTap: (int index) {},
          ),
        ),
      ),
       */
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildKata(),
          _buildKato(),
          _buildKtfs(),
          _buildBabolat(),
          _buildWilson(),
        ],
      ),
    );
  }

  Widget _buildKata() {
    const url = 'http://m.ikata.org';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildKato() {
    const url = 'http://www.kato.kr';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildKtfs() {
    const url = 'http://m.ktfs.or.kr/m_index.php';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildBabolat() {
    const url = 'https://m.cafe.naver.com/ca-fe/pink4wvnx';
    return const CommonWebView(siteUrl: url);
  }

  Widget _buildWilson() {
    const url = 'https://m.cafe.naver.com/ca-fe/web/cafes/30315163';
    return const CommonWebView(siteUrl: url);
  }
}
