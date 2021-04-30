import 'package:blue_fibre/business_logic/feed/bloc/get_single_post_bloc/get_single_post_bloc.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_body_widget.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/comment_textfield_widget.dart';
import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/feed_details_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPostPage extends StatefulWidget {
  const NotificationPostPage({this.postId, this.postOwnerId, this.imageUrls});

  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;

  @override
  _NotificationPostPageState createState() => _NotificationPostPageState();
}

class _NotificationPostPageState extends State<NotificationPostPage> {
  @override
  void initState() {
    print(widget.postId);
    BlocProvider.of<GetSinglePostBloc>(context)
        .add(GetSinglePostByIdEvent(widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GetSinglePostBloc, GetSinglePostState>(
        listener: (BuildContext context, GetSinglePostState state) {
          if (state is ErrorGetSinglePostState) {
            CustomWarningDialog.showCustomDialog(
              context: context,
              title: 'Error',
              message: state.message,
            );
          }
        },
        builder: (BuildContext context, GetSinglePostState state) {
          if (state is LoadingGetSinglePostState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedGetSinglePostState) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    FeedDetailsWidget(post: state.post),
                    const Divider(),
                    CommentBodyWidget(postId: state.post.id),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CommentPageTextField(
                    postId: state.post.id,
                    postOwnerId: state.post.ownerId,
                    imageUrls: state.post.imageUrl,
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('oopps'));
        },
      ),
    );
  }
}
