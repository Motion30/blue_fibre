import 'dart:io';

import 'package:blue_fibre/business_logic/auth/model/login_user_model.dart';
import 'package:blue_fibre/business_logic/auth/model/user_details_model.dart';
import 'package:blue_fibre/business_logic/cloud_messaging/init_notification_class.dart';
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

  Future<Map<String, dynamic>> getLoginUserDetails() async {
    final DocumentSnapshot documentSnapshot =
    await _userCollectionRef.doc(getUserUid()).get();

    return documentSnapshot.data();
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
      await _getIt.get<NotificationClass>().subscribeToChannel(user.uid);

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

  Future<void> registerUserWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String fullName,
    @required String userName,
    @required int phoneNumber,
  }) async {
    try {
      final bool userNameExist = await checkUserName(userName);

      if (userNameExist == false) {
        final UserCredential result =
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final User user = result.user;

        final PostOwnerDetails userData = PostOwnerDetails(
          uid: user.uid,
          email: email,
          fullName: fullName,
          phoneNumber: phoneNumber,
          profilePicUrl: null,
          timestamp: Timestamp.now(),
          userName: userName,
        );

        await writeUserDataToDataBase(userData: userData);
        await _getIt.get<NotificationClass>().subscribeToChannel(user.uid);

        // await HiveMethods().saveUserDataToLocalDb(userData: userData.toMap());

        return userFromFirebase(user);
      } else {
        throw Exception('User Name Already Exist');
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Error: $e');
    }
  }

  Future<PostOwnerDetails> getUserDetails({@required String uid}) async {
    PostOwnerDetails user;

    try {
      final DocumentSnapshot document = await _userCollectionRef.doc(uid).get();
      user = PostOwnerDetails.fromMap(document.data());
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

  Future<Map<String, dynamic>> getUserDetailsMap(String uid) async {
    final DocumentSnapshot document = await _userCollectionRef.doc(uid).get();

    return document.data();
  }

  Future<void> resetEmail({@required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Error: $e');
    }
  }

  Future<bool> checkPhoneNumber(int phoneNumber) async {
    bool phoneNumberExist = false;
    await _userCollectionRef
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 1) {
        phoneNumberExist = true;
      }
    });

    return phoneNumberExist;
  }

  Future<bool> checkUserName(String userName) async {
    bool userNameExist = false;
    await _userCollectionRef
        .where('userName', isEqualTo: userName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 1) {
        userNameExist = true;
      }
    });

    return userNameExist;
  }

  Future<void> writeUserDataToDataBase(
      {@required PostOwnerDetails userData}) async {
    final DocumentReference userRef = _userCollectionRef.doc(userData.uid);

    await userRef.set(userData.toMap());
  }

//
}
