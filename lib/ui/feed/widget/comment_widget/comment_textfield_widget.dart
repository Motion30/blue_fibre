import 'package:blue_fibre/business_logic/feed/bloc/comment_bloc/comment_bloc.dart';
import 'package:blue_fibre/ui/feed/widget/comment_widget/send_comment_button.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPageTextField extends StatefulWidget {
  const CommentPageTextField({@required this.postId, @required this.postOwnerId});

  final String postId;
  final String postOwnerId;

  @override
  _CommentPageTextFieldState createState() => _CommentPageTextFieldState();
}

class _CommentPageTextFieldState extends State<CommentPageTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (BuildContext context, CommentState state) {
        if (state is LoadedCommentState) {
          _textEditingController.clear();
          CustomWarningDialog.showSnackBar(
            context: context,
            message: 'Comment Added. Refresh page to see latest comment',
            warning: false,
          );
        }
        if (state is ErrorCommentState) {
          CustomWarningDialog.showSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CustomTextField(
                controller: _textEditingController,
                title: 'Add a comment....',
                showUnderLine: false,
              ),
            ),
            SendCommentButton(
              callBack: () {
                if (_textEditingController.text.trim().isNotEmpty) {
                  BlocProvider.of<CommentBloc>(context).add(
                    AddCommentEvent(
                        commentText: _textEditingController.text.trim(),
                        postId: widget.postId, postOwnerId: widget.postOwnerId),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
