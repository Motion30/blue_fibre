part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class AddCommentEvent extends CommentEvent {
  const AddCommentEvent({this.commentText, this.postId});

  final String commentText;
  final String postId;

  @override
  List<Object> get props => <Object>[commentText, postId];
}
