import 'package:blue_fibre/business_logic/notification/bloc/get_notification/get_notifications_bloc.dart';
import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:blue_fibre/ui/notification/pages/notification_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_item_wiget.dart';

class NotificationListViewWidget extends StatefulWidget {
  const NotificationListViewWidget({this.notifications, this.lastNotification});

  final List<NotificationModel> notifications;
  final NotificationModel lastNotification;

  @override
  _NotificationListViewWidgetState createState() =>
      _NotificationListViewWidgetState();
}

class _NotificationListViewWidgetState
    extends State<NotificationListViewWidget> {
  ScrollController _controller;

  void scrollController() {
    final GetNotificationsBloc bloc =
        BlocProvider.of<GetNotificationsBloc>(context);

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        bloc.isFetching == false &&
        bloc.hasMore == true) {
      debugPrint('end gotten');
      // bloc.add(FetchNotificationEvent(widget.lastNotification.timestamp));
    }
  }

  @override
  void initState() {
    _controller = ScrollController()..addListener(() => scrollController());
    // BlocProvider.of<GetNotificationsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      controller: _controller,
      itemCount: widget.notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 3.0),
          // color: const Color(0xffbde3ff),
          child: InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //     'notificationPostPage', arguments:
              // <dynamic>[
              //   widget.notifications[index].postLikedId,
              //   widget.notifications[index].commenterId ??
              //       widget.notifications[index].likerId,
              //   widget.notifications[index].postImageUrl ?? <String>[],
              // ]
              // );

              Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => NotificationPostPage(
                    postId: widget.notifications[index].postCommentId ?? widget.notifications[index].postLikedId,
                    postOwnerId: widget.notifications[index].commenterId ??
                        widget.notifications[index].likerId,
                    imageUrls:
                        widget.notifications[index].postImageUrl ?? <String>[],
                  ),
                ),
              );
            },
            child: NotificationItemWidget(widget.notifications[index]),
          ),
        );
      },
    );
  }
}
