import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/get_feeds_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'get_feed_event.dart';

part 'get_feed_state.dart';

class GetFeedBloc extends Bloc<GetFeedEvent, GetFeedState> {
  GetFeedBloc() : super(InitialGetFeedState());
  final GetFeedRepo repo = GetIt.instance.get<GetFeedRepo>();
  bool loadedOnce = false;
  bool isFetching = false;
  bool hasMore = true;

  @override
  Stream<GetFeedState> mapEventToState(
    GetFeedEvent event,
  ) async* {
    if (event is FetchPostEvent) {
      isFetching = true;

      if (event.reload == true) {
        loadedOnce = false;
      }

      try {
        yield LoadingGetFeedState();

        final List<PostModel> post = await repo.fetchPost(
          reload: event.reload,
          personalPostOnly: event.personalPostOnly,
        );

        hasMore = post.length == 5 - 1;

        yield LoadedGetFeedState(post,
            hasMore: hasMore, reloaded: event.reload);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorGetFeedState(e?.message.toString());
      }
      loadedOnce = true;
      isFetching = false;
    }
  }
}
