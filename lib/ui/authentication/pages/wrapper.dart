import 'package:blue_fibre/business_logic/auth/model/login_user_model.dart';
import 'package:blue_fibre/ui/authentication/pages/login_page.dart';
import 'package:blue_fibre/ui/authentication/pages/sign_up_page.dart';
import 'package:blue_fibre/ui/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this wrapper class is here to monitor the auth changes, it returns home
    // page if the user is already logged in and login page if not instance of
    // login is present(no user is already logged in) or the user logged out.
    // provider is being used to monitor the UserStream in the auth method class

    final LoginUserModel user = Provider.of<LoginUserModel>(context);

    if (user == null) {
      return ToggleBetweenLoginAndSignUpWidget();
    } else {
      return HomePage();
    }
  }
}

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
