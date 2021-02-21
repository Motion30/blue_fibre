part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class InitialCommentState extends CommentState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingCommentState extends CommentState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedCommentState extends CommentState {
  @override
  List<Object> get props => <Object>[];
}

class ErrorCommentState extends CommentState {
  const ErrorCommentState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[];
}
