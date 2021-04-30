part of 'get_single_post_bloc.dart';

abstract class GetSinglePostState extends Equatable {
  const GetSinglePostState();
}

class InitialGetSinglePostState extends GetSinglePostState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingGetSinglePostState extends GetSinglePostState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedGetSinglePostState extends GetSinglePostState {
  const LoadedGetSinglePostState(this.post);

  final PostModel post;

  @override
  List<Object> get props => <Object>[post];
}

class ErrorGetSinglePostState extends GetSinglePostState {
  const ErrorGetSinglePostState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}


