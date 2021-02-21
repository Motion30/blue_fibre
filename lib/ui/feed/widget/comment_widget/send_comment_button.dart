import 'package:blue_fibre/business_logic/feed/bloc/comment_bloc/comment_bloc.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCommentButton extends StatelessWidget {
  const SendCommentButton({this.callBack});

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (BuildContext context, CommentState state) {
        if (state is ErrorCommentState) {
          CustomWarningDialog.showSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (BuildContext context, CommentState state) {
        if (state is LoadingCommentState) {
          return const SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(strokeWidth: 2.0,),
          );
        }

        return InkWell(
          onTap: () => callBack(),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            child: const Center(child: Icon(Icons.send, color: Colors.green)),
          ),
        );
      },
    );
  }
}