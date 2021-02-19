import 'package:blue_fibre/ui/feed/widget/upload_widgets/upload_page_body.dart';
import 'package:blue_fibre/utils/navigator_class.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UploadFeedPage extends StatelessWidget {
  const UploadFeedPage();

  void navigate(BuildContext context) {
    final NavigatorClass navigate = GetIt.instance.get<NavigatorClass>();

    navigate.popOffPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: UploadBodyWidget(size: MediaQuery.of(context).size),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('Upload Post', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () => navigate(context),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
    );
  }
}
