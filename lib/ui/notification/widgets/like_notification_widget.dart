import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:flutter/material.dart';

class LikesNotificationWidget extends StatelessWidget {
  const LikesNotificationWidget(this.notification);

  final NotificationModel notification;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('likes'),
    );
  }
}
