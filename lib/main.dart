import 'package:blue_fibre/business_logic/local_db/hive_init.dart';
import 'package:blue_fibre/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitMethods.initHiveDatabase();
  await Firebase.initializeApp();
  ServiceLocator.setup();
  runApp(ProviderScope(child: BlueFiberApp()));
}
