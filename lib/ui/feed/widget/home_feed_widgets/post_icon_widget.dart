import 'package:blue_fibre/business_logic/feed/bloc/update_post_info_blo/update_post_info_bloc.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostIconWidget extends StatelessWidget {
  PostIconWidget({
    @required this.icon,
    this.postId,
    this.postOwnerId,
    this.imageUrls,
    this.postOperationType,
    this.isLiked = false,
  });

  final PostOperationType postOperationType;
  IconData icon;
  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;
  bool isLiked;

  void action(BuildContext context) {
    switch (postOperationType) {
      case PostOperationType.like:
        context.read<UpdatePostInfoBloc>().add(UpdateActionEvent(
              postOwnerId: postOwnerId,
              postOperationType: postOperationType,
              postId: postId,
            imageUrls: imageUrls,
              // postOperationType, postId,
            ));

        if (isLiked) {
          isLiked = false;
          icon = Icons.favorite_border_outlined;
        } else {
          isLiked = true;
          icon = Icons.favorite;
        }
        break;
      case PostOperationType.comment:
        Navigator.of(context).pushNamed(
          '/commentPage',
          arguments: <dynamic>[
            postId,
            postOwnerId,
            imageUrls,
          ],
        );
        break;
      case PostOperationType.bookmark:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: BlocConsumer<UpdatePostInfoBloc, UpdatePostInfoState>(
        listener: (BuildContext context, UpdatePostInfoState state) {},
        builder: (BuildContext context, UpdatePostInfoState state) {
          if (state is LoadingUpdatePostInfoState &&
              BlocProvider.of<UpdatePostInfoBloc>(context).postOperationType ==
                  postOperationType &&
              BlocProvider.of<UpdatePostInfoBloc>(context).postId == postId) {
            return const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          }

          return InkWell(
            onTap: () => action(context),
            child: Icon(icon, color: isLiked ? Colors.red : Colors.grey[700]),
          );
        },
      ),
    );
  }
}
