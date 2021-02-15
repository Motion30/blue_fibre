import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/ui/home/pages/home_page.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPageMessage extends StatelessWidget {
  const LoginPageMessage({this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.30,
      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
      child: const CustomText(
        text: 'Hello Again!\nWelcome\nBack',
        size: 35.0,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({this.size});

  final Size size;

  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> validate() async {
    final FormState formState = formKey.currentState;

    if (formState.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      isLoading.value = true;
      final AuthenticationRepo auth = AuthenticationRepo();

      try {
        await auth.loginWithEmailAndPassword(email: email, password: password);
        debugPrint('Login successfull');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<Widget>(
            builder: (_) => HomePage(),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        CustomWarningDialog.showCustomDialog(
            context: context,
            title: 'Warning',
            message: e.toString(),
        );
      }

      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 30.0),
            CustomTextField(
              controller: emailController,
              title: 'Email Address',
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: passwordController,
              title: 'Password',
              hideText: true,
            ),
            const SizedBox(height: 15.0),
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (_, bool value, Widget child) {
                if (value == true) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CustomButton(
                    size: MediaQuery.of(context).size,
                    title: 'Sign In',
                    onPress: () => validate(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPageMoreOptions extends StatelessWidget {
  const LoginPageMoreOptions({this.size, this.navigate});

  final Size size;
  final Function navigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: size.width,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: const CustomText(
              text: 'Forgot Your password?',
              size: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          InkWell(
            onTap: () => navigate(),
            child: const CustomText(
              text: 'SignUp',
              size: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
