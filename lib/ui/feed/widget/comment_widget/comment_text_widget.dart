import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class CommentTextWidget extends StatelessWidget {
  const CommentTextWidget({this.commentText});

  final String commentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: ExpandableText(
          commentText,
          expandText: 'show more',
          collapseText: 'show less',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 5,
          linkColor: Colors.blue,
        ),
      ),
    );
  }
}
