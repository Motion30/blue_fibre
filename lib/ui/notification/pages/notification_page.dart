import 'package:blue_fibre/ui/notification/widgets/notifcation_body_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Notification', fontWeight: FontWeight.bold,),
        backgroundColor: Colors.white,
      ),
      body: const NotificationBodyWidget(),
    );
  }
}
