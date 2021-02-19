import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';

class MediaHelper {
  Future<List<File>> getImage() async {
    final List<Media> mediaList = await ImagePickers.pickerPaths(
      selectCount: 10,
      showGif: false,
      showCamera: true,
      uiConfig: UIConfig(uiThemeColor: Colors.blue),
    );

    return mediaList.map((Media e) => File(e.path)).toList();
  }
}
