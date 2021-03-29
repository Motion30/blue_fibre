part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class AddCommentEvent extends CommentEvent {
  const AddCommentEvent({this.commentText, this.postId, this.postOwnerId, this.imageUrls});

  final String commentText;
  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;

  @override
  List<Object> get props => <Object>[commentText, postId, postOwnerId, imageUrls];
}
