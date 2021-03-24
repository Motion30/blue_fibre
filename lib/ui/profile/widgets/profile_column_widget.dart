import 'package:blue_fibre/ui/profile/widgets/user_profile_details_widget.dart';
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
      ],
    );
  }
}
