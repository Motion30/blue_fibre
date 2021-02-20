import 'package:blue_fibre/ui/chat/pages/chat_page.dart';
import 'package:blue_fibre/ui/feed/pages/feed_page.dart';
import 'package:blue_fibre/ui/notification/pages/notification_page.dart';
import 'package:blue_fibre/ui/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  // int currentIndex = 0;
  final List<Widget> screenList = <Widget>[
    FeedPage(),
    ChatPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: currentPageIndex,
          builder: (_, int value, Widget child) {
            return screenList[value];
          },
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: currentPageIndex,
          builder: (_, int value, Widget child) {
            return BottomNavigationBar(
              currentIndex: value,
              onTap: (int index) => currentPageIndex.value = index,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: Colors.grey),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.grey,
                  ),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.grey,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  ),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// Widget body(BuildContext context){
//   return
// }
}
