import 'package:blue_fibre/ui/authentication/pages/wrapper.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (BuildContext context) => Wrapper());

      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error Navigator')),
            body: const Text('Error'),
          );
        });
    }
  }
}
