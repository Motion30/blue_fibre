import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostOwnerWidget extends StatelessWidget {
  const PostOwnerWidget({this.postOwnerDetails, this.timestamp});

  final PostOwnerDetailsModel postOwnerDetails;
  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: <Widget>[
          PostOwnerImageWidget(imageUrl: postOwnerDetails?.profileImageUrl),
          const SizedBox(width: 5.0),
          Column(
            children: <Widget>[
              CustomText(
                text: postOwnerDetails.fullName ?? 'Test User',
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: postOwnerDetails == null
                    ? 'testUser'
                    : postOwnerDetails.userName,
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
          const Spacer(),
          PostDateTimeWidget(timestamp: timestamp),
        ],
      ),
    );
  }
}

class PostDateTimeWidget extends StatelessWidget {
  const PostDateTimeWidget({this.timestamp});

  final Timestamp timestamp;

  String get userId => GetIt.instance.get<AuthenticationRepo>().getUserUid();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: CustomText(
        text: timeago.format(timestamp.toDate()),
        size: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class PostOwnerImageWidget extends StatelessWidget {
  const PostOwnerImageWidget({this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey,
      child: CustomImageWidget(
        imageWidgetType:
            imageUrl != null ? ImageWidgetType.network : ImageWidgetType.none,
        imageUrl: imageUrl,
      ),
    );
  }
}
