import 'package:blue_fibre/ui/feed/pages/upload_feed_page.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:blue_fibre/utils/navigator_class.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatelessWidget {
  void navigate(BuildContext context) {
    final NavigatorClass navigate = GetIt.instance.get<NavigatorClass>();

    navigate.pushToNextPage(context: context, page: const UploadFeedPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        callBack: () => navigate(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
