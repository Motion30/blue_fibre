part of 'get_profile_details_bloc.dart';

abstract class GetProfileDetailsState extends Equatable {
  const GetProfileDetailsState();
}

class InitialGetProfileDetailsState extends GetProfileDetailsState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingGetProfileDetailsState extends GetProfileDetailsState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedGetProfileDetailsState extends GetProfileDetailsState {
  const LoadedGetProfileDetailsState(this.userDetails);

  final UserDetailsModel userDetails;

  @override
  List<Object> get props => <Object>[userDetails];
}

class ErrorGetProfileDetailsState extends GetProfileDetailsState {
  const ErrorGetProfileDetailsState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

