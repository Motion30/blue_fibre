import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsModel {
  UserDetailsModel({
    @required this.uid,
    @required this.email,
    @required this.bio,
    @required this.fullName,
    @required this.userName,
    @required this.phoneNumber,
    @required this.profilePicUrl,
    @required this.backgroundPic,
    this.timestamp,
    this.following,
    this.followers,
  });

  String uid;
  String email;
  String fullName;
  String userName;
  String bio;
  int phoneNumber;
  int followers;
  int following;
  String profilePicUrl;
  String backgroundPic;
  Timestamp timestamp;

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'uid': uid,
  //     'email': email,
  //     'fullName': fullName,
  //     'bio': bio,
  //     'userName': userName,
  //     'followers': followers,
  //     'following': following,
  //     'phoneNumber': phoneNumber,
  //     'profilePicUrl': profilePicUrl,
  //     'timestamp': timestamp,
  //   };
  // }

  // ignore: sort_constructors_first
  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber'] as int,
      following: map['following'] as int,
      followers: map['followers'] as int,
      profilePicUrl: map['profilePicUrl'] as String,
      backgroundPic: map['backgroundPic'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  UserDetailsModel copyWith({
    String uid,
    String email,
    String bio,
    String fullName,
    String userName,
    int phoneNumber,
    int following,
    int followers,
    String profilePicUrl,
    Timestamp timestamp,
  }) {
    return UserDetailsModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      backgroundPic: backgroundPic ?? this.backgroundPic,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
