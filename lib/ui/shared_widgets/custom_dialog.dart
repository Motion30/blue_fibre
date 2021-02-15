import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:flutter/material.dart';

class CustomWarningDialog {
  static void showCustomDialog({
    BuildContext context,
    String title,
    String message,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: CustomText(
            text: message,
            size: 16.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
