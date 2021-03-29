import 'package:blue_fibre/business_logic/feed/bloc/get_post_bloc/get_feed_bloc.dart';
import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/feed_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeedListView extends StatefulWidget {
  const HomeFeedListView({this.posts, this.loading, this.personalPostOnly = false,});

  final List<PostModel> posts;
  final bool loading;
  final bool personalPostOnly;

  @override
  _HomeFeedListViewState createState() => _HomeFeedListViewState();
}

class _HomeFeedListViewState extends State<HomeFeedListView> {
  ScrollController _controller;

  Future<void> _scrollController() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        BlocProvider.of<GetFeedBloc>(context).isFetching == false &&
        BlocProvider.of<GetFeedBloc>(context).hasMore == true) {
      print('end');
      BlocProvider.of<GetFeedBloc>(context).add(FetchPostEvent(personalPostOnly: widget.personalPostOnly));
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
        final GetFeedBloc bloc = BlocProvider.of<GetFeedBloc>(context);
        await Future.delayed(const Duration(seconds: 1));

        bloc.add(FetchPostEvent(reload: true, personalPostOnly: widget.personalPostOnly,));
      },
      child: ListView.separated(
        shrinkWrap: true,
        controller: _controller,
        padding: const EdgeInsets.only(top: 10.0),
        separatorBuilder: (_, int index) => const Divider(),
        itemCount: widget.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              FeedDetailsWidget(post: widget.posts[index]),
              if (index == widget.posts.length - 1 && widget.loading == true)
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
