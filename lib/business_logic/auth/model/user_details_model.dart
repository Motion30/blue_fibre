import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostOwnerDetails {
  PostOwnerDetails({
    @required this.uid,
    @required this.email,
    @required this.fullName,
    @required this.userName,
    @required this.phoneNumber,
    @required this.profilePicUrl,
    this.timestamp,
  });

  String uid;
  String email;
  String fullName;
  String userName;
  int phoneNumber;
  String profilePicUrl;
  Timestamp timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'profilePicUrl': profilePicUrl,
      'timestamp': timestamp,
    };
  }

  // ignore: sort_constructors_first
  factory PostOwnerDetails.fromMap(Map<String, dynamic> map) {
    return PostOwnerDetails(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber'] as int,
      profilePicUrl: map['profilePicUrl'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  PostOwnerDetails copyWith({
    String uid,
    String email,
    String fullName,
    String userName,
    int phoneNumber,
    String profilePicUrl,
    Timestamp timestamp,
  }) {
    return PostOwnerDetails(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
