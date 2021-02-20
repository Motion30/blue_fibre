import 'package:flutter/material.dart';

@Deprecated('Should not be used. use the generated named route')
class NavigatorClass {
  @Deprecated('Should not be used. use the generated named route')
  void pushToNextPage({Widget page, BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  @Deprecated('Should not be used. use the generated named route')
  void popOffPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
