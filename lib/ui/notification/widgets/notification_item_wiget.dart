import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';

import 'comment_notification_widget.dart';
import 'like_notification_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(this.notification);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    if (notification.type == NotificationType.likes) {
      return LikesNotificationWidget(notification);
    } else if (notification.type == NotificationType.comment) {
      return CommentNotificationWidget(notification);
    }
    return Container();
  }
}
