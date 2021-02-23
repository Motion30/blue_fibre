import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/feed/repo/update_post_details_repo.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'update_post_info_event.dart';

part 'update_post_info_state.dart';

class UpdatePostInfoBloc
    extends Bloc<UpdatePostInfoEvent, UpdatePostInfoState> {
  UpdatePostInfoBloc() : super(InitialUpdatePostInfoState());
  PostOperationType postOperationType;
  String postId;

  @override
  Stream<UpdatePostInfoState> mapEventToState(
    UpdatePostInfoEvent event,
  ) async* {
    if (event is UpdateActionEvent) {
      postOperationType = event.postOperationType;
      postId = event.postId;
      try {
        yield const LoadingUpdatePostInfoState();
        switch (event.postOperationType) {
          case PostOperationType.like:
            await UpdatePostInfoRepo().updatePostLike(
              postId: event.postId,
              postOwnerId: event.postOwnerId,
            );
            break;
          case PostOperationType.comment:
            // TODO: Handle this case.
            break;
          case PostOperationType.bookmark:
            // TODO: Handle this case.
            break;
        }
        yield const LoadedUpdatePostInfoState();
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield ErrorUpdatePostInfoState(e?.message.toString());
      }
    }
  }
}
