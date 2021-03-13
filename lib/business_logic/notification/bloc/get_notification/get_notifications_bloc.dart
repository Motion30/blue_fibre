import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:blue_fibre/business_logic/notification/repo/notification_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'get_notifications_event.dart';
part 'get_notifications_state.dart';

class GetNotificationsBloc
    extends Bloc<GetNotificationsEvent, GetNotificationsState> {
  GetNotificationsBloc() : super(InitialGetNotificationsState());
  bool isFetching = false;
  bool hasMore = true;

  @override
  Stream<GetNotificationsState> mapEventToState(
    GetNotificationsEvent event,
  ) async* {
    if (event is FetchNotificationEvent) {
      isFetching = true;
      final List<NotificationModel> notifications = <NotificationModel>[];

      try {
        yield LoadingGetNotificationsState();
        final List<Map<String, dynamic>> notificationsData = await GetIt
            .instance
            .get<NotificationRepo>()
            .getNotification(event.lastDocTime);

        for (int i = 0; i < notificationsData.length - 1; i++) {
          final Map<String, dynamic> data = notificationsData[i];

          final Map<String, dynamic> userData = await GetIt.instance
              .get<AuthenticationRepo>()
              .getUserDetailsMap(
                  (data['commenterId'] ?? data['likerId']).toString());

          notifications.add(
            NotificationModel.fromMap(
              notificationMap: data,
              userData: userData,
            ),
          );
        }

        hasMore = notifications.length == 10;
        yield LoadedGetNotificationsState(notifications);
      } catch (e, s) {
        yield ErrorGetNotificationsState(e?.message.toString());
      }
      isFetching = false;
    }
  }
}
