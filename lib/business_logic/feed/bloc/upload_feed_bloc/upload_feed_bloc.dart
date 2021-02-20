import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/feed/repo/upload_feed_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'upload_feed_event.dart';
part 'upload_feed_state.dart';

class UploadFeedBloc extends Bloc<UploadFeedEvent, UploadFeedState> {
  UploadFeedBloc() : super(InitialUploadFeedState());
  final UploadFeedRepo _feedRepo = UploadFeedRepo();

  @override
  Stream<UploadFeedState> mapEventToState(
    UploadFeedEvent event,
  ) async* {
    if (event is UploadNewFeedPostEvent) {
      try {
        yield LoadingUploadFeedState();
        await _feedRepo.uploadPost(
          uploadStreamReport: event.uploadStreamReport,
          images: event.images,
          des: event.des,
        );
        yield LoadedUploadFeedState();
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        yield ErrorUploadFeedState(e?.message.toString());
      }
    }
  }
}
