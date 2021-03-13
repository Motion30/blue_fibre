import 'package:blue_fibre/business_logic/notification/bloc/get_notification/get_notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_list_view.dart';

class NotificationBodyWidget extends StatelessWidget {
  const NotificationBodyWidget({this.fetchCount = 0});

  final int fetchCount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetNotificationsBloc, GetNotificationsState>(
      listener: (BuildContext context, GetNotificationsState state) {},
      builder: (BuildContext context, GetNotificationsState state) {
        if (state is LoadingGetNotificationsState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorGetNotificationsState && fetchCount < 1) {
          return Center(child: Text(state.message));
        } else if (state is LoadedGetNotificationsState) {
          return NotificationListViewWidget(
            notifications: state.notifications,
            lastNotification: state.notifications.last,
          );
        }

        return Container();
      },
    );
  }
}
