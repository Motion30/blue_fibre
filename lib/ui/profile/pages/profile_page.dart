import 'package:blue_fibre/ui/profile/widgets/profile_column_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child:  ProfileColumnWidget());
  }
}
