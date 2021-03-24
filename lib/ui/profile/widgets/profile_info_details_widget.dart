import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/profile/model/user_details.dart';
import 'package:blue_fibre/ui/profile/widgets/profile_button.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfileInfoAndDetailsWidget extends StatelessWidget {
  const ProfileInfoAndDetailsWidget(this.userDetails);

  final UserDetailsModel userDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: userDetails.fullName,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 5.0),
          CustomText(
            text: userDetails.userName,
            size: 17,
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: CustomText(
              text: userDetails.bio ??
                  'Sir Isaac Newton PRS (25 December 1642 – 20 March 1726/27) was an English mathematician, physicist, astronomer, theologian, and author (described in his time as a "natural philosopher") who is widely recognised as one of the greatest mathematicians and most influential scientists of all time and as a key figure in the',
              size: 15.5,
              fontWeight: FontWeight.w300,
              maxLine: 3,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              CustomText(
                text: '${userDetails.following ?? 0} Following',
                size: 16,
              ),
              const SizedBox(width: 10.0),
              CustomText(
                text: '${userDetails.followers ?? 0} Followers',
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          if (GetIt.instance.get<AuthenticationRepo>().getUserUid() ==
              userDetails.uid)
            Container()
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                ProfileButton('Message'),
                SizedBox(width: 10.0),
                ProfileButton('Follow'),
              ],
            ),
        ],
      ),
    );
  }
}
