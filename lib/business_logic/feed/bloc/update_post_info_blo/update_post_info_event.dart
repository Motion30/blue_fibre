part of 'update_post_info_bloc.dart';

abstract class UpdatePostInfoEvent extends Equatable {
  const UpdatePostInfoEvent();
}

class UpdateActionEvent extends UpdatePostInfoEvent {
  const UpdateActionEvent(
      {this.postOperationType, this.postId, this.postOwnerId, this.imageUrls});

  final PostOperationType postOperationType;
  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;

  @override
  List<Object> get props => <Object>[postOperationType, postOwnerId, imageUrls];
}
