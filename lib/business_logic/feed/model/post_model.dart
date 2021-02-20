import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  const PostModel({
    @required this.description,
    @required this.imageUrl,
    @required this.postOwnerDetails,
    @required this.ownerId,
    this.likesCount = 0,
    this.commentCount = 0,
    this.timestamp,
    this.id,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      description: map['description'] as String,
      imageUrl: List<String>.from(map['imageUrl'] as List<dynamic>),
      likesCount: map['likesCount'] as int,
      commentCount: map['commentCount'] as int,
      timestamp: map['timestamp'] as Timestamp,
      ownerId: map['ownerId'] as String,
      postOwnerDetails: PostOwnerDetailsModel.fromMap(
          map['postOwnerDetails'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String description;
  final List<String> imageUrl;
  final int likesCount;
  final int commentCount;
  final Timestamp timestamp;
  final PostOwnerDetailsModel postOwnerDetails;
  final String ownerId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': Uuid().v4(),
      'description': description,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'commentCount': commentCount,
      'timestamp': Timestamp.now(),
      'postOwnerDetails': postOwnerDetails.toMap(),
      'ownerId': ownerId,
    };
  }
}
