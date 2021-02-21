import 'package:blue_fibre/business_logic/feed/bloc/view_comment_bloc/view_comment_bloc.dart';
import 'package:blue_fibre/business_logic/feed/model/comment_model.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentListViewWidget extends StatefulWidget {
  const CommentListViewWidget({
    this.comments,
    this.loading,
    this.callback,
    this.refresh,
  });

  final List<CommentModel> comments;
  final bool loading;
  final Function callback;
  final Function refresh;

  @override
  _CommentListViewWidgetState createState() => _CommentListViewWidgetState();
}

class _CommentListViewWidgetState extends State<CommentListViewWidget> {
  ScrollController _controller;

  void scrollController() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        BlocProvider.of<ViewCommentBloc>(context).isFetching == false &&
        BlocProvider.of<ViewCommentBloc>(context).hasMore == true) {
      print('buttom');
      widget.callback();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(() => scrollController());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await widget.refresh(),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        controller: _controller,
        separatorBuilder: (_, int index) => const Divider(),
        padding: const EdgeInsets.only(bottom: 20.0),
        itemCount: widget.comments.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CommentWidget(comment: widget.comments[index]),
              if (index == widget.comments.length - 1 &&
                  widget.loading != false)
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator(strokeWidth: 2.0),
                )
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}
