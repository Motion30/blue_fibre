import 'package:blue_fibre/ui/authentication/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage(this.callBack);

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SignUpPageMessage(size: size),
          SignUpPageForm(size: size),
          SignUpPageMoreOptions(size: size, navigate: () => callBack()),
          SizedBox(
            height: size.height * 0.10,
            child: Container(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
