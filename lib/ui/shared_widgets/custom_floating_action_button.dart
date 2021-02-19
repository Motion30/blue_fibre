import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    @required this.callBack,
    this.backGroundColor,
    @required this.child,
  });

  final VoidCallback callBack;
  final Widget child;
  final Color backGroundColor;



  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: callBack,
      backgroundColor: backGroundColor ?? Theme.of(context).primaryColor,
      child: child,
    );
  }
}
