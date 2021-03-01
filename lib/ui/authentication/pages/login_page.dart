import 'package:blue_fibre/ui/authentication/widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this.callBack);

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LoginPageMessage(size: size),
          LoginPageForm(size: size),
          LoginPageMoreOptions(size: size, navigate: () => callBack()),
        ],
      ),
    );
  }
}
