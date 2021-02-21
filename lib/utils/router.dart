import 'package:blue_fibre/ui/authentication/pages/wrapper.dart';
import 'package:blue_fibre/ui/feed/pages/comment_page.dart';
import 'package:blue_fibre/ui/feed/pages/upload_feed_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => Wrapper(),
        );
        break;
      case '/uploadFeedPage':
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const UploadFeedPage(),
        );
        break;
      case '/commentPage':
        if(arguments is String) {
          return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => CommentPage(postId: arguments),
          );
        }
        break;

      default:
        return MaterialPageRoute<Widget>(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error Navigator')),
            body: const Center(child: Text('Error')),
          );
        });
    }
  }
}
