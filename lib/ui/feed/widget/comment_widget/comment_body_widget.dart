import 'package:blue_fibre/business_logic/feed/bloc/view_comment_bloc/view_comment_bloc.dart';
import 'package:blue_fibre/business_logic/feed/model/comment_model.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comments_listview_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBodyWidget extends StatefulWidget {
  const CommentBodyWidget({this.postId});

  final String postId;

  @override
  _CommentBodyWidgetState createState() => _CommentBodyWidgetState();
}

class _CommentBodyWidgetState extends State<CommentBodyWidget> {
  final List<DocumentSnapshot> _comments = <DocumentSnapshot>[];
  bool loading = false;
  DocumentSnapshot lastDoc;

  Future<void> refresh() async {
    _comments.clear();
    BlocProvider.of<ViewCommentBloc>(context)
        .add(GetPostComment(postId: widget.postId));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ViewCommentBloc>(context)
        .add(GetPostComment(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.885,
        child: BlocConsumer<ViewCommentBloc, ViewCommentState>(
          listener: (BuildContext context, ViewCommentState state) {
            if (state is LoadedViewCommentState) {
              _comments.addAll(state.comments);
              if (state.comments.isNotEmpty) {
                lastDoc = state.comments.last;
              }
              loading = false;
            } else if (state is ErrorViewCommentState) {
              CustomWarningDialog.showSnackBar(
                context: context,
                message: state.message,
              );
            }
          },
          builder: (BuildContext context, ViewCommentState state) {
            if (state is LoadingViewCommentState) {
              if (_comments.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                );
              } else {
                loading = true;
              }
            }

            if (_comments.isEmpty) {
              return ListView(
                padding:  EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.30,
                ),
                children: const <Widget>[
                  Center(child: Text('No Comment Found')),
                ],
              );
            }

            return CommentListViewWidget(
              comments: _comments
                  .map((DocumentSnapshot e) => CommentModel.fromMap(e.data()))
                  .toList(),
              loading: loading,
              callback: () => BlocProvider.of<ViewCommentBloc>(context)
                  .add(GetPostComment(lastDoc: lastDoc, postId: widget.postId)),
            );
          },
        ),
      ),
    );
  }
}
