import 'package:flutter/material.dart';

class PostOwnerDetailsModel {
  PostOwnerDetailsModel({
    @required this.userName,
    @required this.profileImageUrl,
  });

  factory PostOwnerDetailsModel.fromMap(Map<String, dynamic> map) {
    return PostOwnerDetailsModel(
      userName: map == null ? 'Test User' : map['userName'] as String,
      profileImageUrl: map == null ? null : map['profileImageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'profileImageUrl': profileImageUrl,
    };
  }

  String userName;
  String profileImageUrl;
}
