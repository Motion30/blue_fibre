import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  const NotificationModel({
    @required this.id,
    @required this.likerId,
    @required this.commenterId,
    @required this.postLikedId,
    @required this.postImageUrl,
    @required this.postCommentId,
    @required this.comment,
    @required this.timestamp,
    @required this.type,
    @required this.read,
    @required this.postOwnerDetailsModel,
  });

  factory NotificationModel.fromMap({Map<String, dynamic> notificationMap, Map<String, dynamic> userData,}) {
    return NotificationModel(
      id: notificationMap['id'] as String,
      likerId: notificationMap['likerId'] as String,
      commenterId: notificationMap['commenterId'] as String,
      comment: notificationMap['comment'] as String,
        postImageUrl: List<String>.from(notificationMap['imageUrls'] as List<dynamic> ?? <String>[]),
      postLikedId: notificationMap['postLikedId'] as String,
      postCommentId: notificationMap['postCommentId'] as String,
      timestamp: notificationMap['timestamp'] as Timestamp,
      type:  notificationMap['type'] == 'likes' ? NotificationType.likes : NotificationType.comment,
      read: notificationMap['read'] as bool,
        postOwnerDetailsModel: PostOwnerDetailsModel.fromMap(userData)
    );
  }

  final String id;
  final String likerId;
  final String commenterId;
  final List<String> postImageUrl;
  final String postLikedId;
  final String postCommentId;
  final String comment;
  final Timestamp timestamp;
  final NotificationType type;
  final bool read;
  final PostOwnerDetailsModel postOwnerDetailsModel;


  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return <String, dynamic>{
    'id': id,
    'likerId': likerId,
    'commenterId': commenterId,
    'postImageUrl': postImageUrl,
    'postLikedId': postLikedId,
    'postCommentId': postCommentId,
    'comment': comment,
    'timestamp': timestamp,
    'type': type,
    'read': read,
    'postOwnerDetailsModel': postOwnerDetailsModel,
    };
  }



}
