import 'package:blue_fibre/ui/feed/widget/home_feed_widgets/home_page_body.dart';
import 'package:flutter/material.dart';

class UsersPostWidget extends StatelessWidget {
  const UsersPostWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: const FeedHomePageBodyWidget(personalPostOnly: true),
    );
  }
}
