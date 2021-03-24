import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(this.title, {this.callback});

  final String title;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 6.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: CustomText(text: title, size: 16.0),
      ),
    );
  }
}
