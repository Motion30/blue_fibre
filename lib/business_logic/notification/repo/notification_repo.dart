import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class NotificationRepo {
  static final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('userData');

  Future<List<Map<String, dynamic>>> getNotification(Timestamp lastDocTime) async {
    final String userUid =
        GetIt.instance.get<AuthenticationRepo>().getUserUid();
    List<Map<String, dynamic>> data;

    Query query =  userCollectionRef
        .doc(userUid)
        .collection('notification')
        .orderBy('timestamp', descending: true)
        .limit(10);

    if(lastDocTime != null){
      query = query.startAfter([lastDocTime]);
    }

    final QuerySnapshot querySnapshot = await query.get();

    // ignore: join_return_with_assignment
    data = querySnapshot.docs
        .map((QueryDocumentSnapshot queryDocumentSnapshot) =>
            queryDocumentSnapshot.data())
        .toList();

    return data;
  }
}
