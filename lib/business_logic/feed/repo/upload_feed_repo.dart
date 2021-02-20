import 'dart:async';
import 'dart:io';

import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/model/post_owner_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class UploadFeedRepo {
  static const String _feed = 'feeds';
  static const String postImagePath = 'images/posts';

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _feedCollectionRef =
      _firestore.collection(_feed);

  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<String>> _uploadImage({
    List<File> images,
    StreamController<String> uploadStreamReport,
  }) async {
    final List<String> imageUrls = <String>[];

    //first Report
    uploadStreamReport.add('Preparing To Upload ${images.length} Images');
    debugPrint('start image uploading');

    for (int i = 0; i < images.length; i++) {
      debugPrint('start image uploading image $i');
      final Reference postStorageRef =
          _firebaseStorage.ref(postImagePath).child(DateTime.now().toString());

      final UploadTask task = postStorageRef.putFile(images[i]);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadStreamReport.add(
            '$i Of ${images.length} Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      });

      debugPrint('start image uploading image $i....');
      await task;
      final String downloadURL = await postStorageRef.getDownloadURL();
      debugPrint(downloadURL);
      imageUrls.add(downloadURL);
    }

    uploadStreamReport.add('Done Uploading Images');

    return imageUrls;
  }

  Future<void> _addPostToFirestore(PostModel post) async {
    print(post.id);
    await _feedCollectionRef.doc(post.id).set(post.toMap());
  }

  Future<void> uploadPost({
    List<File> images,
    StreamController<String> uploadStreamReport,
    String des,
  }) async {
    uploadStreamReport.add('Preparing To Upload Post');

    final List<String> _imagesUrls = await _uploadImage(
      images: images,
      uploadStreamReport: uploadStreamReport,
    );

    final Map<String, dynamic> _userDetails =
        await GetIt.instance.get<AuthenticationRepo>().getLoginUserDetails();

    final PostModel post = PostModel(
      id: Uuid().v4(),
      description: des,
      imageUrl: _imagesUrls,
      ownerId: GetIt.instance.get<AuthenticationRepo>().getUserUid(),
      postOwnerDetails: PostOwnerDetailsModel.fromMap(_userDetails),
    );

    await _addPostToFirestore(post);

    uploadStreamReport.add('Done Uploading Post');
  }
}
