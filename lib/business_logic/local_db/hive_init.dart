import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveInitMethods {
  static Future<void> _startUserDataHiveDb() async {
    /// This method will be called at the start of the app, this will start
    /// a local Database this will host/store the user Data.

    Directory documentDir = await getApplicationSupportDirectory();
    Hive.init(documentDir.path);
    await Hive.openBox('userData');
    debugPrint('open userDat');
  }

  static Future<void> initHiveDatabase() async {
    await _startUserDataHiveDb();
  }
}
