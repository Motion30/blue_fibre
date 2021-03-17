part of 'get_feed_bloc.dart';

abstract class GetFeedEvent extends Equatable {
  const GetFeedEvent();
}

class FetchPostEvent extends GetFeedEvent{

  const FetchPostEvent({this.reload  = false});

  final bool reload;
  @override
  List<Object> get props => <Object>[];
}