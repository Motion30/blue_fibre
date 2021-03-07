import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostTextWidget extends StatelessWidget {
  const PostTextWidget(this.textPost);

  final String textPost;
  @override
  Widget build(BuildContext context) {
    return textPost != ''
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ExpandableText(
              textPost,
              maxLines: 3,
              expandText: 'show more',
              collapseText: 'show less',
            ),
          )
        : Container();
  }
}
