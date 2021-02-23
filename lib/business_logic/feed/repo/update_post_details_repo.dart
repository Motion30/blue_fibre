import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/model/likes_model.dart';
import 'package:blue_fibre/utils/firestore_document_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class UpdatePostInfoRepo {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _feedCollectionRef =
      _firestore.collection(firebaseFeedCollectionRefName);
  static final CollectionReference _likesCollectionRef =
      _firestore.collection(firebaseLikesCollectionRefName);

  Future<bool> _checkIfLikedAlready(String postId) async {
    bool alreadyLiked;
    final QuerySnapshot querySnapshot = await _likesCollectionRef
        .where('postLikedId', isEqualTo: postId)
        .where('likerId',
            isEqualTo: GetIt.instance.get<AuthenticationRepo>().getUserUid())
        .get();

    if (querySnapshot.docs.isEmpty) {
      alreadyLiked = false;
    } else {
      alreadyLiked = true;
    }

    return alreadyLiked;
  }

  Future<void> likePost(String postId, String postOwnerId,
      [String likeDocRef]) async {
    final WriteBatch _writeBatch = _firestore.batch();

    // update like count on post
    _writeBatch.update(
      _feedCollectionRef.doc(postId),
      <String, dynamic>{'likesCount': FieldValue.increment(1)},
    );

    // add like data to likes collection
    if (likeDocRef == null) {
      _writeBatch.set(
        _likesCollectionRef.doc(),
        LikesModel(
          likerId: GetIt.instance.get<AuthenticationRepo>().getUserUid(),
          postLikedId: postId,
          postOwnerId: postOwnerId,
        ).toMap(),
      );
    } else {
      _writeBatch.set(
        _likesCollectionRef.doc(likeDocRef),
        LikesModel(
          likerId: GetIt.instance.get<AuthenticationRepo>().getUserUid(),
          postLikedId: postId,
          postOwnerId: postOwnerId,
        ).toMap(),
      );
    }

    await _writeBatch.commit();
  }

  Future<void> updatePostLike({
    String postId,
    String postOwnerId,
  }) async {
    if (await _checkIfLikedAlready(postId) == false) {
      await likePost(postId, postOwnerId);
    } else {
      await _disLikePost(postId);
    }
  }

  Future<void> _disLikePost(String postId) async {
    final WriteBatch _writeBatch = _firestore.batch();

    final QuerySnapshot querySnapshot = await _likesCollectionRef
        .where('postLikedId', isEqualTo: postId)
        .where('likerId',
            isEqualTo: GetIt.instance.get<AuthenticationRepo>().getUserUid())
        .get();

    final DocumentSnapshot documentSnapshot = querySnapshot.docs?.first;
    final LikesModel like = LikesModel.fromMap(documentSnapshot.data());

    if (like.liked == true) {
      _writeBatch.update(
        _likesCollectionRef.doc(documentSnapshot.id),
        <String, dynamic>{'liked': false},
      );

      _writeBatch.update(
        _feedCollectionRef.doc(postId),
        <String, dynamic>{'likesCount': FieldValue.increment(-1)},
      );

      await _writeBatch.commit();
    } else {
      await likePost(postId, documentSnapshot.id);
    }
  }
}
