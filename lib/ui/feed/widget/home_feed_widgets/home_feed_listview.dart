import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/feed_details_widget.dart';
import 'package:flutter/material.dart';

class HomeFeedListView extends StatelessWidget {
  const HomeFeedListView({this.posts, this.callBack});

  final List<PostModel> posts;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('loading');
        await callBack();
        debugPrint('loaded');
      },
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10.0),
        separatorBuilder: (_, int index) => const Divider(),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return FeedDetailsWidget(post: posts[index]);
        },
      ),
    );
  }
}
