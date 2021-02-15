import 'dart:io';

import 'package:blue_fibre/business_logic/auth/model/login_user_model.dart';
import 'package:blue_fibre/business_logic/auth/model/user_details_model.dart';
import 'package:blue_fibre/utils/firestore_document_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationRepo {
  final GetIt _getIt = GetIt.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection(firestoreUserData);

  LoginUserModel userFromFirebase(User user) {
    return user != null ? LoginUserModel(uid: user.uid) : null;
  }

  Stream<LoginUserModel> get userStream {
    /// emit a stream of user current state(e.g emit an event when the user
    /// log out so the UI can be notify and update as needed or emit a event when
    /// a user log in so the UI can also be updated

    return _auth.authStateChanges().map(userFromFirebase);
  }

  String getUserUid() {
    return _auth.currentUser.uid;
  }

  Future<dynamic> loginWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = result.user;
      debugPrint(user.uid);
      await getUserDetails(uid: user.uid);

      return userFromFirebase(user);
    } on SocketException {
      debugPrint('No Internet Connection!');
      throw Exception('Error: No Internet Connection!');
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(e.message.toString());
      debugPrint(s.toString());
      throw Exception('Error: ${e.message}');
    }
  }

  Future<UserModel> getUserDetails({@required String uid}) async {
    UserModel user;

    try {
      final DocumentSnapshot document = await _userCollectionRef.doc(uid).get();
      user = UserModel.fromMap(document.data());
      // final HiveMethods hiveMethods = _getIt.get<HiveMethods>();
      // await hiveMethods.saveUserDataToLocalDb(userData: user.toMap());
    } on SocketException {
      throw Exception('No Internet Connection!');
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Error: $e');
    }

    return user;
  }

  //
}
