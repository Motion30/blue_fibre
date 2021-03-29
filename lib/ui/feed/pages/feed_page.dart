import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/home_page_body.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const FeedHomePageBodyWidget(),
      floatingActionButton: CustomFloatingActionButton(
        callBack: () => Navigator.of(context).pushNamed('/uploadFeedPage'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
