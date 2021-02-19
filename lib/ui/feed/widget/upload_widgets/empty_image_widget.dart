import 'package:flutter/material.dart';

class UploadEmptyImageWidget extends StatelessWidget {
  const UploadEmptyImageWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}