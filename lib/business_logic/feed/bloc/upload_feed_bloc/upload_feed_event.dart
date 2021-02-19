part of 'upload_feed_bloc.dart';

abstract class UploadFeedEvent extends Equatable {
  const UploadFeedEvent();
}

class UploadNewFeedPostEvent extends UploadFeedEvent {
  const UploadNewFeedPostEvent({this.images, this.uploadStreamReport, this.des});

  final List<File> images;
  final StreamController<String> uploadStreamReport;
  final String des;

  @override
  List<Object> get props => [images, uploadStreamReport, des];
}
