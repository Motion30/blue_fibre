import 'package:blue_fibre/business_logic/profile/bloc/get_profile_details/get_profile_details_bloc.dart';
import 'package:blue_fibre/ui/profile/widgets/profile_info_details_widget.dart';
import 'package:blue_fibre/ui/profile/widgets/user_profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_widgets/custom_text.dart';

class UserProfileDetailsWidget extends StatelessWidget {
  const UserProfileDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetProfileDetailsBloc, GetProfileDetailsState>(
      listener: (BuildContext context, GetProfileDetailsState state) {},
      builder: (BuildContext context, GetProfileDetailsState state) {
        if (state is LoadingGetProfileDetailsState) {
          return const SizedBox(
            height: 200,
            child:  Center(child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ErrorGetProfileDetailsState) {
          return Center(child: CustomText(text: state.message));
        } else if (state is LoadedGetProfileDetailsState) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              UserProfileImageWidget(
                profileImage: state.userDetails.profilePicUrl,
                backgroundImage: state.userDetails.backgroundPic,
              ),
              ProfileInfoAndDetailsWidget(state.userDetails),
            ],
          );
        }
        return Container();
      },
    );
  }
}
