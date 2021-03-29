import 'package:flutter/material.dart';

class NotificationPostPage extends StatelessWidget {
  const NotificationPostPage({this.postId, this.postOwnerId, this.imageUrls});

  final String postId;
  final String postOwnerId;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}
