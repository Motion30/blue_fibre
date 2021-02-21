part of 'view_comment_bloc.dart';

abstract class ViewCommentEvent extends Equatable {
  const ViewCommentEvent();
}

class GetPostComment extends ViewCommentEvent {
  const GetPostComment({this.lastDoc, this.postId});

  final DocumentSnapshot lastDoc;
  final String postId;

  @override
  List<Object> get props => <Object>[];
}
