import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_body_widget.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_textfield_widget.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({
    @required this.postId,
    @required this.postOwnerId,
    @required this.imageUrls,
  });

  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CommentBodyWidget(postId: postId),
            const Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommentPageTextField(
                postId: postId,
                postOwnerId: postOwnerId,
                imageUrls: imageUrls,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
