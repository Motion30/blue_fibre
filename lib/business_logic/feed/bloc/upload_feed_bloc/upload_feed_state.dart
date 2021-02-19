part of 'upload_feed_bloc.dart';

abstract class UploadFeedState extends Equatable {
  const UploadFeedState();
}

class InitialUploadFeedState extends UploadFeedState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingUploadFeedState extends UploadFeedState {
  @override
  List<Object> get props => <Object>[];
}

class LoadedUploadFeedState extends UploadFeedState {
  @override
  List<Object> get props => <Object>[];
}

class ErrorUploadFeedState extends UploadFeedState {
  const ErrorUploadFeedState(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[];
}
