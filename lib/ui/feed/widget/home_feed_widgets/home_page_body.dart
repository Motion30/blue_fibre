import 'package:blue_fibre/business_logic/feed/bloc/get_post_bloc/get_feed_bloc.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/home_feed_listview.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/feed/model/post_model.dart';

class FeedHomePageBodyWidget extends StatefulWidget {
  const FeedHomePageBodyWidget({this.personalPostOnly = false});

  final bool personalPostOnly;

  @override
  _FeedHomePageBodyWidgetState createState() => _FeedHomePageBodyWidgetState();
}

class _FeedHomePageBodyWidgetState extends State<FeedHomePageBodyWidget> {
  List<PostModel> _post = <PostModel>[];
  bool _loading;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetFeedBloc>(context).add(
        FetchPostEvent(personalPostOnly: widget.personalPostOnly));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocConsumer<GetFeedBloc, GetFeedState>(
        listener: (BuildContext context, GetFeedState state) {
          if (state is ErrorGetFeedState) {
            CustomWarningDialog.showCustomDialog(
              title: 'Error',
              message: state.message,
              context: context,
            );
          } else if (state is LoadedGetFeedState) {
            if (state.reloaded == true) {
              _post = state.post;
            } else {
              _post.addAll(state.post);
            }
            _loading = state.hasMore;
          }
        },
        builder: (BuildContext context, GetFeedState state) {
          if (state is LoadingGetFeedState &&
              BlocProvider
                  .of<GetFeedBloc>(context)
                  .loadedOnce == false) {
            return const Center(child: CircularProgressIndicator());
          }

          return HomeFeedListView(posts: _post,
            loading: _loading,
            personalPostOnly: widget.personalPostOnly,);
        },
      ),
    );
  }
}
