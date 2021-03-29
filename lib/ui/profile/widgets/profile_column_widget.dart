import 'package:blue_fibre/ui/profile/widgets/user_profile_details_widget.dart';
import 'package:blue_fibre/ui/profile/widgets/users_post_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileColumnWidget extends StatelessWidget {
  const ProfileColumnWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const <Widget>[
        UserProfileDetailsWidget(),
        Divider(),
        Center(
            child: CustomText(text: 'Posts', fontWeight: FontWeight.w500, size: 18),
        ),
        Divider(),
        UsersPostWidget(),
      ],
    );
  }
}
