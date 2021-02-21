import 'package:blue_fibre/business_logic/feed/model/comment_model.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_text_widget.dart';
import 'package:flutter/material.dart';

import 'comment_user_details.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({this.comment});

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CommenterUserDetails(
            postOwnerDetails: comment.postOwnerDetails,
            timestamp: comment.timestamp,
          ),
          CommentTextWidget(commentText: comment.comment),
        ],
      ),
    );
  }
}
