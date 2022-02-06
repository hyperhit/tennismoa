import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: SilverAppBarWithTabBarScreen(),
    ));

class SilverAppBarWithTabBarScreen extends StatefulWidget {
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState();
}

class _SilverAppBarWithTabBarState extends State<SilverAppBarWithTabBarScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("SilverAppBar title"),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            // **Is it intended ?** flexibleSpace.title overlaps with tabs title.
            flexibleSpace: FlexibleSpaceBar(
              title: Text("FlexibleSpace title"),
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
              controller: _controller,
            ),
          ),
          // SliverList(
          SliverFillRemaining(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                Center(child: Text("Tab one")),
                Center(child: Text("Tab two")),
                Center(child: Text("Tab three")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
