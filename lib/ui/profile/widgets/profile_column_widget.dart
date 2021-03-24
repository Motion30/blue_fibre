import 'package:blue_fibre/ui/profile/widgets/user_profile_details_widget.dart';
import 'package:flutter/material.dart';

class ProfileColumnWidget extends StatelessWidget {
  const ProfileColumnWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListView(
        shrinkWrap: true,
        children: const <Widget>[
          UserProfileDetailsWidget(),
        ],
      ),
    );
  }
}
