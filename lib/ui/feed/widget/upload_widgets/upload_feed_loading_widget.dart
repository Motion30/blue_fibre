import 'dart:async';

import 'package:flutter/material.dart';

class UploadLoadingWidget extends StatelessWidget {
  const UploadLoadingWidget({this.uploadReport});

  final StreamController<String> uploadReport;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          const Center(child: CircularProgressIndicator()),
          StreamBuilder<String>(
            stream: uploadReport.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text(
                snapshot.data.toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}
