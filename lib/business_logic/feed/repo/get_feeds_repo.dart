import 'dart:async';

import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:blue_fibre/utils/firestore_document_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFeedRepo {
  static const int _perPage = 5;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _postCollectionRef =
      _firestore.collection(firebaseFeedCollectionRefName);

  final StreamController<List<PostModel>> allRequestedFeed =
      StreamController<List<PostModel>>.broadcast();
  final List<List<PostModel>> _allPagesList = <List<PostModel>>[];

  DocumentSnapshot _lastDoc;
  bool hasMore = true;
  bool isFetching = false;

  Future<void> getPost(BuildContext context) async {
    _fetchPost(context);
    await Future.delayed(const Duration(seconds: 3));
  }

  void _fetchPost(BuildContext context) {
    Query _postQuery = _postCollectionRef
        .orderBy('timestamp', descending: true)
        .limit(_perPage);

    if (_lastDoc != null) {
      _postQuery = _postQuery.startAfterDocument(_lastDoc);
    }

    if (!hasMore) return;

    isFetching = true;

    final int _currentPageIndex = _allPagesList.length;

    try {
      _postQuery.snapshots().listen((QuerySnapshot querySnapshot) {
        final List<PostModel> _currentPageList = querySnapshot.docs
            .map((QueryDocumentSnapshot queryDocumentSnapshot) =>
                PostModel.fromMap(queryDocumentSnapshot.data()))
            .toList();

        debugPrint('list: $_currentPageList');

        if (_currentPageIndex < _allPagesList.length - 1) {
          _allPagesList[_currentPageIndex] = _currentPageList;
        } else {
          _allPagesList.add(_currentPageList);
        }

        if (_currentPageIndex == _allPagesList.length - 1 &&
            _currentPageList.isNotEmpty) {
          _lastDoc = querySnapshot.docs.last;
        }

        hasMore = _currentPageList.length == _perPage;

        final List<PostModel> allPost = _allPagesList.fold(
            <PostModel>[],
            (List<PostModel> previousValue, List<PostModel> element) =>
                previousValue..addAll(element));

        allRequestedFeed.add(allPost);
      });
    } catch (e) {
      CustomWarningDialog.showCustomDialog(
        title: 'Error',
        message: e?.message.toString(),
        context: context,
      );
    }

    isFetching = false;
  }


}
