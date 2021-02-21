part of 'view_comment_bloc.dart';

abstract class ViewCommentState extends Equatable {
  const ViewCommentState();
}

class InitialViewCommentState extends ViewCommentState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingViewCommentState extends ViewCommentState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedViewCommentState extends ViewCommentState {
  const LoadedViewCommentState(this.comments);

  final List<DocumentSnapshot> comments;

  @override
  List<Object> get props => <Object>[comments];
}

class ErrorViewCommentState extends ViewCommentState {
  const ErrorViewCommentState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
