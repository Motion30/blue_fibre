import 'package:blue_fibre/ui/authentication/pages/wrapper.dart';
import 'package:blue_fibre/ui/feed/pages/comment_page.dart';
import 'package:blue_fibre/ui/feed/pages/upload_feed_page.dart';
import 'package:blue_fibre/ui/notification/pages/notification_post_page.dart';
import 'package:blue_fibre/ui/setting/pages/setting_page.dart';
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
      case '/settingsPage':
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const SettingsPage(),
        );
        break;
      case '/commentPage':
        if (arguments is List<dynamic>) {
          return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => CommentPage(
              postId: arguments[0] as String,
              postOwnerId: arguments[1] as String,
              imageUrls: List<String>.from(arguments[2] as List<String>),
            ),
          );
        }
        break;
      case '/notificationPostPage':
        print(arguments);
        if (arguments is List<dynamic>) {
          return MaterialPageRoute<Widget>(
            builder: (BuildContext context) => NotificationPostPage(
              postId: arguments[0] as String,
              postOwnerId: arguments[1] as String,
              imageUrls: List<String>.from(arguments[2] as List<String>),
            ),
          );
        }
        break;

      default:
        return MaterialPageRoute<Widget>(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error Navigator')),
              body: const Center(child: Text('Error Navigating')),
            );
          },
        );
    }
  }
}
