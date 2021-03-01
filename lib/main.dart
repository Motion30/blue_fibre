import 'package:blue_fibre/business_logic/local_db/hive_init.dart';
import 'package:blue_fibre/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'business_logic/cloud_messaging/init_notification_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitMethods.initHiveDatabase();
  await Firebase.initializeApp();
  NotificationClass().init();
  ServiceLocator.setup();
  runApp(BlueFiberApp());
}
