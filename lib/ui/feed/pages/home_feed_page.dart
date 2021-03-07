import 'package:blue_fibre/ui/feed/pages/feed_page.dart';
import 'package:blue_fibre/ui/feed/pages/news_feed_page.dart';
import 'package:flutter/material.dart';

class FeedHomePage extends StatefulWidget {
  const FeedHomePage();

  @override
  _FeedHomePageState createState() => _FeedHomePageState();
}

class _FeedHomePageState extends State<FeedHomePage> {
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);

  final List<Widget> pages = const <Widget>[NewsFeedPage(), FeedPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Theme.of(context).primaryColor,
                ),
                // indicatorWeight: 4.0,
                onTap: (int index) => pageIndex.value = index,
                tabs: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Tab(text: 'News'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Tab(text: 'Post'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: pageIndex,
                builder: (_, int value, Widget child) {
                  return IndexedStack(index: value, children: pages);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
