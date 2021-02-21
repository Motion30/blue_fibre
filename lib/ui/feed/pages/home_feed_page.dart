import 'package:blue_fibre/ui/feed/pages/feed_page.dart';
import 'package:blue_fibre/ui/feed/pages/news_feed_page.dart';
import 'package:flutter/material.dart';

class FeedHomePage extends StatefulWidget {
  const FeedHomePage();

  @override
  _FeedHomePageState createState() => _FeedHomePageState();
}

class _FeedHomePageState extends State<FeedHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  final List<Widget> pages = const <Widget>[NewsFeedPage(), FeedPage()];

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              indicatorWeight: 4.0,
              onTap: (int index) => pageIndex.value = index,
              controller: _controller,
              tabs: const <Widget>[
                Tab(text: 'News'),
                Tab(text: 'Post'),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.840,
            child: ValueListenableBuilder<int>(
              valueListenable: pageIndex,
              builder: (_, int value, Widget child) {
                return IndexedStack(index: value, children: pages);
              },
            ),
          ),
        ],
      ),
    );
  }
}
