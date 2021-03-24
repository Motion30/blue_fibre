import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blue_fibre/business_logic/profile/model/user_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../auth/repo/authentication_repo.dart';

part 'get_profile_details_event.dart';

part 'get_profile_details_state.dart';

class GetProfileDetailsBloc
    extends Bloc<GetProfileDetailsEvent, GetProfileDetailsState> {
  GetProfileDetailsBloc() : super(InitialGetProfileDetailsState());

  @override
  Stream<GetProfileDetailsState> mapEventToState(
      GetProfileDetailsEvent event,) async* {
    if (event is GetUserProfileEvent) {
      try {
        yield LoadingGetProfileDetailsState();
        final Map<String, dynamic> data = await GetIt.instance.get<
            AuthenticationRepo>().getUserDetailsMap(
            GetIt.instance.get<AuthenticationRepo>().getUserUid(),
        );

        final UserDetailsModel userDetails = UserDetailsModel.fromMap(data);

        yield LoadedGetProfileDetailsState(userDetails);
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());

        yield ErrorGetProfileDetailsState(e?.toString());
      }
    }
  }
}
