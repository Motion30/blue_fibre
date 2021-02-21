import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/feed/repo/comment_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'view_comment_event.dart';

part 'view_comment_state.dart';

class ViewCommentBloc extends Bloc<ViewCommentEvent, ViewCommentState> {
  ViewCommentBloc() : super(InitialViewCommentState());
  static const int _commentLimit = 8;
  bool isFetching = false;
  bool hasMore = true;

  @override
  Stream<ViewCommentState> mapEventToState(
    ViewCommentEvent event,
  ) async* {
    if (event is GetPostComment) {
      isFetching = true;
      try {
        yield LoadingViewCommentState();

        final List<DocumentSnapshot> comments = await GetIt.instance
            .get<CommentRepo>()
            .getComment(postId: event.postId, lastDoc: event.lastDoc);
        hasMore = comments.length == _commentLimit;

        yield LoadedViewCommentState(comments);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield ErrorViewCommentState(e?.message.toString());
      }

      isFetching = false;
    }
  }
}
