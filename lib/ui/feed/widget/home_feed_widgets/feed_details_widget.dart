import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/post_footer_widget.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/post_image_widget.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/post_owner_widget.dart';
import 'package:flutter/material.dart';

class FeedDetailsWidget extends StatelessWidget {
  const FeedDetailsWidget({this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PostOwnerWidget(
          postOwnerDetails: post?.postOwnerDetails,
          postOwnerId: post?.ownerId,
        ),
        PostImageWidget(imageList: post.imageUrl),
        PostFooterWidget(post: post),
      ],
    );
  }
}
