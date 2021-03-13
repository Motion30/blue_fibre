import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';

class CommentNotificationWidget extends StatelessWidget {
  const CommentNotificationWidget(this.notification);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            child: notification.postOwnerDetailsModel.profileImageUrl != null ? CustomImageWidget(
              imageWidgetType: ImageWidgetType.network,
              imageUrl: notification.postOwnerDetailsModel.profileImageUrl,
            ) : const Center(child: Icon(Icons.person)),
          ),
        ],
      ),
    );
  }
}


