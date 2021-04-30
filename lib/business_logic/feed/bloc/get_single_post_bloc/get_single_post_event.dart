part of 'get_single_post_bloc.dart';

abstract class GetSinglePostEvent extends Equatable {
  const GetSinglePostEvent();
}

class GetSinglePostByIdEvent extends GetSinglePostEvent {
  const GetSinglePostByIdEvent(this.postId);

  final String postId;

  @override
  List<Object> get props => <Object>[postId];

}