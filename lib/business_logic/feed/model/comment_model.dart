import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CommentModel {
  const CommentModel({
    @required this.commentId,
    @required this.comment,
    @required this.imageUrls,
    @required this.commenterId,
    @required this.postCommentId,
    @required this.timestamp,
    @required this.postOwnerDetails,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] as String,
      commentId: map['commentId'] as String,
      imageUrls: List<String>.from(map['imageUrls'] as List<dynamic>),
      commenterId: map['commenterId'] as String,
      postCommentId: map['postCommentId'] as String,
      postOwnerDetails: PostOwnerDetailsModel.fromMap(
          map['postOwnerDetails'] as Map<String, dynamic>),
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  final String comment;
  final String commentId;
  final List<String> imageUrls;
  final String commenterId;
  final String postCommentId;
  final Timestamp timestamp;
  final PostOwnerDetailsModel postOwnerDetails;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'commentId': commentId,
      'imageUrls': imageUrls,
      'commenterId': commenterId,
      'postCommentId': postCommentId,
      'postOwnerDetails': postOwnerDetails.toMap(),
      'timestamp': timestamp,
    };
  }
}
