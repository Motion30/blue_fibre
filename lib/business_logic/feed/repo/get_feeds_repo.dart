import 'dart:async';

import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/post_model.dart';
import 'package:blue_fibre/business_logic/feed/repo/update_post_details_repo.dart';
import 'package:blue_fibre/utils/firestore_document_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class GetFeedRepo {
  static const int perPage = 5;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _postCollectionRef =
      _firestore.collection(firebaseFeedCollectionRefName);

  DocumentSnapshot _lastDoc;
  bool _hasMore = true;

  Future<PostModel> getSinglePostById(String postId) async {
    final DocumentSnapshot documentSnapshot =
        await _postCollectionRef.doc(postId).get();

    print(documentSnapshot.data());

    final bool _isLiked = await GetIt.instance
        .get<UpdatePostInfoRepo>()
        .checkIfLikedAlready(postId);

    final PostModel post = PostModel.fromMap(
      documentSnapshot.data(),
      isLiked: _isLiked,
    );

    return post;
  }

  Future<List<PostModel>> fetchPost({
    bool reload = false,
    bool personalPostOnly = false,
  }) async {
    final List<PostModel> post = <PostModel>[];

    if (_hasMore == false && reload == false) {
      return post;
    }

    Query _postQuery = _postCollectionRef
        .orderBy('timestamp', descending: true)
        .limit(perPage);

    if (personalPostOnly == true) {
      _postQuery = _postQuery.where(
        'ownerId',
        isEqualTo: GetIt.instance.get<AuthenticationRepo>().getUserUid(),
      );
    }

    if (_lastDoc != null && reload == false) {
      _postQuery = _postQuery.startAfterDocument(_lastDoc);
    }

    final QuerySnapshot querySnapshot = await _postQuery.get();

    if (querySnapshot.docs.isNotEmpty) {
      _lastDoc = querySnapshot.docs.last;
    }

    for (int i = 0; i < querySnapshot.docs.length - 1; i++) {
      final QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs[i];

      final bool _isLiked = await GetIt.instance
          .get<UpdatePostInfoRepo>()
          .checkIfLikedAlready(queryDocumentSnapshot.id);

      post.add(
        PostModel.fromMap(queryDocumentSnapshot.data(), isLiked: _isLiked),
      );
    }

    _hasMore = post.length == perPage - 1;
    print(post.length);
    print(_hasMore);
    return post;
  }

  Stream<DocumentSnapshot> likeAndCommentStream(String docId) async* {
    yield* _postCollectionRef.doc(docId).snapshots();
  }
}
