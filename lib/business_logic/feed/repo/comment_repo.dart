import 'package:blue_fibre/business_logic/feed/model/comment_model.dart';
import 'package:blue_fibre/utils/firestore_document_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepo {
  static const int _commentLimit = 8;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _commentCollectionRef =
      _firestore.collection(firebaseCommentCollectionRefName);
  static final CollectionReference _feedCollectionRef =
      _firestore.collection(firebaseFeedCollectionRefName);

  Future<List<DocumentSnapshot>> getComment({
    DocumentSnapshot lastDoc,
    String postId,
  }) async {
    Query query = _commentCollectionRef
        .where('postCommentId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .limit(_commentLimit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final QuerySnapshot querySnapshot = await query.get();

    return querySnapshot.docs;
  }

  Future<void> makeComment(CommentModel commentModel) async {
    final WriteBatch _writeBatch = _firestore.batch();

    _writeBatch.set(
      _commentCollectionRef.doc(commentModel.commentId),
      commentModel.toMap(),
    );

    _writeBatch.update(
      _feedCollectionRef.doc(commentModel.postCommentId),
      <String, dynamic>{'commentCount': FieldValue.increment(1)},
    );

    await _writeBatch.commit();
  }
}
