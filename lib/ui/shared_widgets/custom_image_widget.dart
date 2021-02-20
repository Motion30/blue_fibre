import 'dart:io';

import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    @required this.imageWidgetType,
    this.imageUrl,
    this.imageFile,
    this.boxFit = BoxFit.fill,
  });

  final ImageWidgetType imageWidgetType;
  final String imageUrl;
  final File imageFile;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    switch (imageWidgetType) {
      case ImageWidgetType.network:
        return Image.network(
          imageUrl,
          fit: BoxFit.fill,
        );
        break;
      case ImageWidgetType.file:
        return Image.file(
          imageFile,
          fit:boxFit,
        );
        break;
      case ImageWidgetType.asset:
        return Image.asset(
          imageUrl,
          fit: BoxFit.fill,
        );
        break;
      case ImageWidgetType.none:
        return Center(child: Icon(Icons.person, color: Colors.grey[700]));
        break;
      default:
        return Center(child: Icon(Icons.person, color: Colors.grey[700]));
        break;
    }
  }
}
