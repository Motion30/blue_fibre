import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:blue_fibre/utils/date_time_format.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommenterUserDetails extends StatelessWidget {
  const CommenterUserDetails({this.postOwnerDetails, this.timestamp});

  final PostOwnerDetailsModel postOwnerDetails;
  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[300],
          child: CustomImageWidget(
            imageWidgetType: postOwnerDetails.profileImageUrl != null
                ? ImageWidgetType.network
                : ImageWidgetType.none,
            imageUrl: postOwnerDetails.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: postOwnerDetails.userName,
              fontWeight: FontWeight.bold,
              size: 16,
            ),
            CustomText(
              text: DateTimeFormatter.formatData(timestamp),
              fontWeight: FontWeight.w300,
              size: 14,
            ),
          ],
        ),
      ],
    );
  }
}
