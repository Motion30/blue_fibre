import 'package:blue_fibre/business_logic/notification/model/notification_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LikesNotificationWidget extends StatelessWidget {
  const LikesNotificationWidget(this.notification);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[300],
        child: notification.postOwnerDetailsModel.profileImageUrl != null
            ? CustomImageWidget(
                imageWidgetType: ImageWidgetType.network,
                imageUrl: notification.postOwnerDetailsModel.profileImageUrl,
              )
            : Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                ),
              ),
      ),
      title: CustomText(
        text: '${notification.postOwnerDetailsModel.userName} liked your post',
      ),
      subtitle: CustomText(
        text: timeago.format(notification.timestamp.toDate()),
      ),
      trailing: Container(
        width: 50,
        height: 50,
        color: Colors.grey[300],
        child: notification.postImageUrl != null &&
                notification.postImageUrl.isNotEmpty
            ? CustomImageWidget(
                imageWidgetType: ImageWidgetType.network,
                imageUrl: notification.postImageUrl[0],
              )
            : Container(),
      ),
    );
  }
}
