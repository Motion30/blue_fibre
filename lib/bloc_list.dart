import 'package:blue_fibre/business_logic/feed/bloc/comment_bloc/comment_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/get_post_bloc/get_feed_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/update_post_info_blo/update_post_info_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/upload_feed_bloc/upload_feed_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/view_comment_bloc/view_comment_bloc.dart';
import 'package:blue_fibre/business_logic/notification/bloc/get_notification/get_notifications_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/profile/bloc/get_profile_details/get_profile_details_bloc.dart';

List<BlocProvider<Cubit<Object>>> blocList() {
  return <BlocProvider<Cubit<Object>>>[
    BlocProvider<UploadFeedBloc>(
      create: (BuildContext context) => UploadFeedBloc(),
    ),
    BlocProvider<GetFeedBloc>(create: (BuildContext context) => GetFeedBloc()),
    BlocProvider<UpdatePostInfoBloc>(
      create: (BuildContext context) => UpdatePostInfoBloc(),
    ),
    BlocProvider<CommentBloc>(
      create: (BuildContext context) => CommentBloc(),
    ),
    BlocProvider<ViewCommentBloc>(
      create: (BuildContext context) => ViewCommentBloc(),
    ),
    BlocProvider<GetNotificationsBloc>(
      create: (BuildContext context) =>
          GetNotificationsBloc()..add(const FetchNotificationEvent(null)),
    ),
    BlocProvider<GetProfileDetailsBloc>(
      create: (BuildContext context) => GetProfileDetailsBloc()..add(const GetUserProfileEvent()),
    ),
  ];
}
