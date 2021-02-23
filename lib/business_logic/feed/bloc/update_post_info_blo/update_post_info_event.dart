part of 'update_post_info_bloc.dart';

abstract class UpdatePostInfoEvent extends Equatable {
  const UpdatePostInfoEvent();
}

class UpdateActionEvent extends UpdatePostInfoEvent {
  const UpdateActionEvent(
      {this.postOperationType, this.postId, this.postOwnerId});

  final PostOperationType postOperationType;
  final String postId;
  final String postOwnerId;

  @override
  List<Object> get props => [postOperationType, postOwnerId];
}
