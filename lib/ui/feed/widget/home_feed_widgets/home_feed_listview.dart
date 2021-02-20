import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/get_feeds_repo.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/feed_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeFeedListView extends StatefulWidget {
  const HomeFeedListView({this.posts, this.callBack});

  final List<PostModel> posts;
  final Function callBack;

  @override
  _HomeFeedListViewState createState() => _HomeFeedListViewState();
}

class _HomeFeedListViewState extends State<HomeFeedListView> {
  ScrollController _controller;
  final ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  Future<void> _scrollController() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        GetIt.instance.get<GetFeedRepo>().isFetching == false) {
      loading.value = true;
      await widget.callBack();
      loading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(() => _scrollController());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.callBack();
      },
      child: ListView.separated(
        controller: _controller,
        padding: const EdgeInsets.only(top: 10.0),
        separatorBuilder: (_, int index) => const Divider(),
        itemCount: widget.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              FeedDetailsWidget(post: widget.posts[index]),
              if (index == widget.posts.length - 1)
                const CircularProgressIndicator()
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}
