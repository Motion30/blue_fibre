import 'package:flutter/material.dart';

class PostOwnerDetailsModel {
  PostOwnerDetailsModel({
    @required this.userName,
    @required this.profileImageUrl,
    @required this.fullName,
  });

  factory PostOwnerDetailsModel.fromMap(Map<String, dynamic> map) {
    return PostOwnerDetailsModel(
      userName: map == null ? '@testUser' : map['userName'] as String,
      profileImageUrl: map == null ? null : map['profileImageUrl'] as String,
      fullName: map == null ? 'Test User' : map['fullName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'profileImageUrl': profileImageUrl,
      'fullName': fullName,
    };
  }

  String userName;
  String fullName;
  String profileImageUrl;
}
