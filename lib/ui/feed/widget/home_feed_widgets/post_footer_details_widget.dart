import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../business_logic/feed/repo/get_feeds_repo.dart';

class PostFooterDetails extends StatelessWidget {
  const PostFooterDetails({Key key, this.post}) : super(key: key);
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: StreamBuilder<DocumentSnapshot>(
          stream:
              GetIt.instance.get<GetFeedRepo>().likeAndCommentStream(post.id),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: '${post.likesCount} Likes',
                    fontWeight: FontWeight.w300,
                  ),
                  CustomText(
                    text: '${post.commentCount} Comments',
                    fontWeight: FontWeight.w300,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Error occurred');
            }

            final PostModel streamPost = PostModel.fromMap(snapshot.data.data());

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomText(
                  text: '${streamPost.likesCount} Likes',
                  fontWeight: FontWeight.w300,
                ),
                CustomText(
                  text: '${streamPost.commentCount} Comments',
                  fontWeight: FontWeight.w300,
                ),
              ],
            );
          }),
    );
  }
}
