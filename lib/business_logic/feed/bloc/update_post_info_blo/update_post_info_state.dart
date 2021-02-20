part of 'update_post_info_bloc.dart';

abstract class UpdatePostInfoState extends Equatable {
  const UpdatePostInfoState();
}

class InitialUpdatePostInfoState extends UpdatePostInfoState {
  @override
  List<Object> get props => [];
}

class LoadingUpdatePostInfoState extends UpdatePostInfoState {
  const LoadingUpdatePostInfoState();
  @override
  List<Object> get props => [];
}

class LoadedUpdatePostInfoState extends UpdatePostInfoState {
  const LoadedUpdatePostInfoState();
  @override
  List<Object> get props => [];
}

class ErrorUpdatePostInfoState extends UpdatePostInfoState {
  const ErrorUpdatePostInfoState(this.message);
  final String message;


  @override
  List<Object> get props => [message];
}

