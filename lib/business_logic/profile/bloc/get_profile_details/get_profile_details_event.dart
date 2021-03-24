part of 'get_profile_details_bloc.dart';

abstract class GetProfileDetailsEvent extends Equatable {
  const GetProfileDetailsEvent();
}

class GetUserProfileEvent extends GetProfileDetailsEvent{
  const  GetUserProfileEvent();
  @override
  List<Object> get props => [];
}