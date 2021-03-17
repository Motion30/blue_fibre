part of 'get_feed_bloc.dart';

abstract class GetFeedState extends Equatable {
  const GetFeedState();
}

class InitialGetFeedState extends GetFeedState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingGetFeedState extends GetFeedState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedGetFeedState extends GetFeedState {
  const LoadedGetFeedState(this.post, {this.hasMore, this.reloaded});

  final List<PostModel> post;
  final bool hasMore;
  final bool reloaded;
  @override
  List<Object> get props => <Object>[post];
}

class ErrorGetFeedState extends GetFeedState {
  const ErrorGetFeedState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
