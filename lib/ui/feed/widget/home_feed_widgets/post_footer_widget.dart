import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/post_footer_details_widget.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/post_icon_widget.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';

class PostFooterWidget extends StatelessWidget {
  const PostFooterWidget({this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PostFooterDetails(post: post),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              PostIconWidget(
                icon: Icons.favorite_border_outlined,
                postOperationType: PostOperationType.like,
                postId: post.id,
                postOwnerId: post.ownerId,
              ),
              PostIconWidget(
                icon: Icons.mode_comment_outlined,
                postId: post.id,
                postOperationType: PostOperationType.comment,
                postOwnerId: post.ownerId,
              ),
              const Spacer(),
              PostIconWidget(
                icon: Icons.bookmarks_outlined,
                postId: post.id,
                // postOperationType: PostOperationType.bookmark,
              ),
            ],
          ),


        ],
      ),
    );
  }
}
