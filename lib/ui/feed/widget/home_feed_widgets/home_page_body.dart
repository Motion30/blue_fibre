import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/get_feeds_repo.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/home_feed_listview.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedHomePageBodyWidget extends StatefulWidget {
  @override
  _FeedHomePageBodyWidgetState createState() => _FeedHomePageBodyWidgetState();
}

class _FeedHomePageBodyWidgetState extends State<FeedHomePageBodyWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    GetIt.instance.get<GetFeedRepo>().getPost(context);
  }

  @override
  void dispose() {
    GetIt.instance.get<GetFeedRepo>().allRequestedFeed.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<List<PostModel>>(
        stream: GetIt.instance.get<GetFeedRepo>().allRequestedFeed.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          debugPrint(snapshot.toString());
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data.isEmpty) {
            return const Center(child: Text('No Post Found'));
          }

          if (snapshot.hasError) {
            CustomWarningDialog.showCustomDialog(
              title: 'Error',
              message: snapshot.error.toString(),
              context: context,
            );
          }

          return HomeFeedListView(
            posts: snapshot.data,
            callBack: () => GetIt.instance.get<GetFeedRepo>().getPost(context),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
