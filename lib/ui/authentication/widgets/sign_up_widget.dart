import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPageMessage extends StatelessWidget {
  const SignUpPageMessage({this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
      child: const CustomText(
        text: 'Hello\nSign-Up To\nGet Started',
        size: 35.0,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}

class SignUpPageForm extends StatefulWidget {
  const SignUpPageForm({this.size});

  final Size size;

  @override
  _SignUpPageFormState createState() => _SignUpPageFormState();
}

class _SignUpPageFormState extends State<SignUpPageForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> validate() async {
    final FormState formState = formKey.currentState;

    if (formState.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final int phone = int.parse(phoneController.text.trim());
      final String fullName = fullNameController.text.trim();
      final String userName = userNameController.text.trim();

      isLoading.value = true;
      final AuthenticationRepo auth = AuthenticationRepo();

      try {
        await auth.registerUserWithEmailAndPassword(
          email: email,
          password: password,
          fullName: fullName,
          phoneNumber: phone,
          userName: userName,
        );

        debugPrint('SignUp successfull');
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute<Widget>(
        //     builder: (_) => HomePage(),
        //   ),
        // );
      } catch (e) {
        debugPrint(e.toString());
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
              controller: fullNameController,
              title: 'Full Name',
              length: 3,
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: userNameController,
              title: 'User Name',
              length: 3,
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: emailController,
              title: 'Email Address',
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: phoneController,
              title: 'Phone Number',
              keyboardType: TextInputType.number,
              length: 10,
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: passwordController,
              title: 'Password',
              length: 6,
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
                    title: 'SignUp',
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

class SignUpPageMoreOptions extends StatelessWidget {
  const SignUpPageMoreOptions({this.size, this.navigate});

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
            onTap: () => navigate(),
            child: const CustomText(
              text: 'Already Have An account? Sign In',
              size: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
