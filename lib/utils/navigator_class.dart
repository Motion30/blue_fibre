import 'package:flutter/material.dart';

class NavigatorClass {
  void pushToNextPage({Widget page, BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  void popOffPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
