import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage(this.callBack);

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text('SignUp Page'),
          FlatButton(
            onPressed: () => callBack(),
            child: const Text('next'),
          ),
        ],
      ),
    );
  }
}
