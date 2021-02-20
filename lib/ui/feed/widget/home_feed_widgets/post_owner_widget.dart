import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PostOwnerWidget extends StatelessWidget {
  const PostOwnerWidget({this.postOwnerDetails, this.postOwnerId});

  final PostOwnerDetailsModel postOwnerDetails;
  final String postOwnerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: <Widget>[
          PostOwnerImageWidget(imageUrl: postOwnerDetails?.profileImageUrl),
          const SizedBox(width: 5.0),
          CustomText(
            text: postOwnerDetails == null
                ? 'Test User'
                : postOwnerDetails.userName,
            fontWeight: FontWeight.w300,
          ),
          const Spacer(),
          PostOptionIcon(postOwnerId: postOwnerId),
        ],
      ),
    );
  }
}

class PostOptionIcon extends StatelessWidget {
  const PostOptionIcon({this.postOwnerId});

  final String postOwnerId;

  String get userId => GetIt.instance.get<AuthenticationRepo>().getUserUid();

  @override
  Widget build(BuildContext context) {
    if (postOwnerId != userId) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_vert_outlined, color: Colors.grey[700]),
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
