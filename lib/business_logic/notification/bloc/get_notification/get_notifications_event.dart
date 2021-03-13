part of 'get_notifications_bloc.dart';

abstract class GetNotificationsEvent extends Equatable {
  const GetNotificationsEvent();
}

class FetchNotificationEvent extends GetNotificationsEvent{
  const FetchNotificationEvent(this.lastDocTime);
  final Timestamp lastDocTime;

  @override
  List<Object> get props => <Object>[lastDocTime];
}