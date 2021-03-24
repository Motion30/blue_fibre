import 'package:blue_fibre/ui/chat/pages/chat_page.dart';
import 'package:blue_fibre/ui/feed/pages/home_feed_page.dart';
import 'package:blue_fibre/ui/notification/pages/notification_page.dart';
import 'package:blue_fibre/ui/profile/pages/profile_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  final List<Widget> screenList = <Widget>[
    const FeedHomePage(),
    const ChatPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: currentPageIndex,
          builder: (_, int value, Widget child) {
            return IndexedStack(
              index: value,
              children: screenList,
            );
          },
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: currentPageIndex,
          builder: (_, int value, Widget child) {
            return FloatingNavbar(
              backgroundColor: Colors.white,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (int val) => currentPageIndex.value = val,
              currentIndex: value,
              items: <FloatingNavbarItem>[
                FloatingNavbarItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                FloatingNavbarItem(
                    icon: Icons.chat_bubble_outline, title: 'Chats'),
                FloatingNavbarItem(
                    icon: Icons.notifications_none_outlined,
                    title: 'Notification'),
                FloatingNavbarItem(
                    icon: Icons.person_outline_rounded, title: 'Profile'),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ValueListenableBuilder<int>(
// valueListenable: currentPageIndex,
// builder: (_, int value, Widget child) {
// return screenList[value];
// },
// ),
