import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/comment_model.dart';
import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/comment_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(InitialCommentState());
  final AuthenticationRepo _auth = GetIt.instance.get<AuthenticationRepo>();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event,) async* {
    if (event is AddCommentEvent) {
      try {
        yield LoadingCommentState();

        final Map<String, dynamic> userData = await _auth.getLoginUserDetails();

        final CommentModel comment = CommentModel(
          comment: event.commentText,
          postOwnerDetails: PostOwnerDetailsModel.fromMap(userData),
          commenterId: _auth.getUserUid(),
          commentId: Uuid().v1(),
          imageUrls: <String>[],
          postCommentId: event.postId,
          timestamp: Timestamp.now(),
        );

        await GetIt.instance.get<CommentRepo>().makeComment(comment);

        yield LoadedCommentState();
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield ErrorCommentState(e?.message.toString());
      }
    }
  }
}
