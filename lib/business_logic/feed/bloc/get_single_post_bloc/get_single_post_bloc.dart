import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/get_feeds_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'get_single_post_event.dart';

part 'get_single_post_state.dart';

class GetSinglePostBloc extends Bloc<GetSinglePostEvent, GetSinglePostState> {
  GetSinglePostBloc() : super(InitialGetSinglePostState());

  @override
  Stream<GetSinglePostState> mapEventToState(GetSinglePostEvent event,) async* {
    if (event is GetSinglePostByIdEvent) {
      try {
        yield LoadingGetSinglePostState();
        final PostModel post = await GetIt.instance.get<GetFeedRepo>()
            .getSinglePostById(event.postId);
        yield LoadedGetSinglePostState(post);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorGetSinglePostState(e?.message.toString());
      }
    }
  }
}
