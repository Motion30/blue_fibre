import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikesModel {
  const LikesModel({
    @required this.likerId,
    this.liked = true,
    @required this.postLikedId,
    @required this.postOwnerId,
    @required this.imageUrls,
    this.timestamp,
  });

  factory LikesModel.fromMap(Map<String, dynamic> map) {
    return LikesModel(
      likerId: map['likerId'] as String,
      liked: map['liked'] as bool,
      postLikedId: map['postLikedId'] as String,
      postOwnerId: map['postOwnerId'] as String,
      timestamp: map['timestamp'] as Timestamp,
      imageUrls: map['imageUrls'] as List<dynamic>,
    );
  }

  final String likerId;
  final bool liked;
  final String postLikedId;
  final String postOwnerId;
  final List<dynamic> imageUrls;
  final Timestamp timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'likerId': likerId,
      'liked': liked,
      'postLikedId': postLikedId,
      'postOwnerId': postOwnerId,
      'imageUrls': imageUrls,
      'timestamp': Timestamp.now(),
    };
  }
}
