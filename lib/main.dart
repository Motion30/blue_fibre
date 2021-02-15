import 'package:blue_fibre/business_logic/local_db/hive_init.dart';
import 'package:blue_fibre/ui/authentication/pages/wrapper.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitMethods.initHiveDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Fiber',
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
      ),
      home: ToggleBetweenLoginAndSignUpWidget(),
    );
  }
}
