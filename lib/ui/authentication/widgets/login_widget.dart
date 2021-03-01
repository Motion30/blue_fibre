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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: const Icon(Icons.arrow_back_ios),
        ),
        Container(
          width: size.width,
          height: size.height * 0.10,
          padding: const EdgeInsets.only(left: 30.0, top: 20.0),
          child: const CustomText(
            text: 'Sign In',
            size: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 5.0),
            InkWell(
              onTap: () {},
              child: const CustomText(
                text: 'Forgot password?',
                size: 14,
                fontWeight: FontWeight.w400,
              ),
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
                    title: 'Login',
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CustomText(
            text: 'New on Blue fibre?',
            size: 16,
            fontWeight: FontWeight.w300,
          ),
          InkWell(
            onTap: () => navigate(),
            child: CustomText(
              text: ' Sign Up',
              size: 16,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
