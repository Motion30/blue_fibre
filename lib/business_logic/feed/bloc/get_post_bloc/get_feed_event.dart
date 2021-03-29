part of 'get_feed_bloc.dart';

abstract class GetFeedEvent extends Equatable {
  const GetFeedEvent();
}

class FetchPostEvent extends GetFeedEvent{

  const FetchPostEvent({this.reload  = false, this.personalPostOnly  = false});

  final bool reload;
  final bool personalPostOnly;

  @override
  List<Object> get props => <Object>[reload, personalPostOnly];
}