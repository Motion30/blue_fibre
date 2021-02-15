import 'package:blue_fibre/ui/authentication/pages/login_page.dart';
import 'package:blue_fibre/ui/authentication/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class ToggleBetweenLoginAndSignUpWidget extends StatelessWidget {
  static final ValueNotifier<bool> toggleValue = ValueNotifier<bool>(true);

  static void changePage() {
    toggleValue.value = !toggleValue.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: toggleValue,
      builder: (_, bool value, Widget child) {
        if (value == true) {
          return const LoginPage(changePage);
        } else {
          return const SignUpPage(changePage);
        }
      },
    );
  }
}
