part of 'get_notifications_bloc.dart';

abstract class GetNotificationsState extends Equatable {
  const GetNotificationsState();
}

class InitialGetNotificationsState extends GetNotificationsState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingGetNotificationsState extends GetNotificationsState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedGetNotificationsState extends GetNotificationsState {
  const LoadedGetNotificationsState(this.notifications);

  final List<NotificationModel> notifications;
  @override
  List<Object> get props => <Object>[];
}

class ErrorGetNotificationsState extends GetNotificationsState {
  const ErrorGetNotificationsState(this.message);

  final String message;


  @override
  List<Object> get props => <Object>[message];
}

