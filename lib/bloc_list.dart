import 'package:blue_fibre/business_logic/feed/bloc/comment_bloc/comment_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/update_post_info_blo/update_post_info_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/upload_feed_bloc/upload_feed_bloc.dart';
import 'package:blue_fibre/business_logic/feed/bloc/view_comment_bloc/view_comment_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider<Cubit<Object>>> blocList() {
  return <BlocProvider<Cubit<Object>>>[
    BlocProvider<UploadFeedBloc>(
      create: (BuildContext context) => UploadFeedBloc(),
    ),
    BlocProvider<UpdatePostInfoBloc>(
      create: (BuildContext context) => UpdatePostInfoBloc(),
    ),
    BlocProvider<CommentBloc>(
      create: (BuildContext context) => CommentBloc(),
    ),BlocProvider<ViewCommentBloc>(
      create: (BuildContext context) => ViewCommentBloc(),
    ),
  ];
}
