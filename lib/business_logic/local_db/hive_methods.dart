import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveMethods {
  Future<Box<Map>> getOpenBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    } else {
      return Hive.box(boxName);
    }
  }

  Future<Box<Map<dynamic, dynamic>>> getUserDetailsFromLocalDb() async {
    final Box<Map<dynamic, dynamic>> box = await getOpenBox('userDataDb');
    return box;
  }

  Future<void> saveUserDataToLocalDb({
    @required Map<String, dynamic> userData,
  }) async {
    final Box<Map<dynamic, dynamic>> userBox = await getOpenBox('userDataDb');
    const String key = 'userData';
    final Map<String, dynamic> _userData = userData;

    _userData['timestamp'] = _userData['timestamp'].toString();
    await userBox.put(key, _userData);
    debugPrint('user data saved to Local db');
  }

  Future<Map<dynamic, dynamic>> getUserData() async {
    final Box<Map<dynamic, dynamic>> box = await getOpenBox('userDataDb');
    final Map<dynamic, dynamic> data = box.values.toList()[0];
    return data;
  }
}
