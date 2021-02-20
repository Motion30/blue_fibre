import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PostFooterDetails extends StatelessWidget {
  const PostFooterDetails({Key key, this.post}) : super(key: key);
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: '${post.likesCount} Likes and ${post.commentCount} Comments',
            fontWeight: FontWeight.w300,
          ),
          const SizedBox(height: 3.0),
          if (post.description != '') CustomText(
                  text: post.description,
                  fontWeight: FontWeight.w300,
                ) else Container(),
        ],
      ),
    );
  }
}
