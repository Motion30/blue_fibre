import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_textfield_widget.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({@required this.postId});

  final String postId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Divider(),
            CommentPageTextField(postId: postId),
          ],
        ),
      ),
    );
  }
}
