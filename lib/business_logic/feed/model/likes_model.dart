import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikesModel {
  const LikesModel({
    @required this.likerId,
    this.liked = true,
    @required this.postLikedId,
    this.timestamp,
  });

  factory LikesModel.fromMap(Map<String, dynamic> map) {
    return LikesModel(
      likerId: map['likerId'] as String,
      liked: map['liked'] as bool,
      postLikedId: map['postLikedId'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  final String likerId;
  final bool liked;
  final String postLikedId;
  final Timestamp timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'likerId': likerId,
      'liked': liked,
      'postLikedId': postLikedId,
      'timestamp': Timestamp.now(),
    };
  }
}
