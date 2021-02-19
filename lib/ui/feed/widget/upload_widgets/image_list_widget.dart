import 'dart:io';

import 'package:flutter/material.dart';

class UploadImageListWidget extends StatelessWidget {
  const UploadImageListWidget({this.imageList, this.callback});

  final List<File> imageList;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (_, int index){
          return Stack(
            children: <Widget>[
              Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                height: 180,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    imageList[index],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 5.0,
                right: 10.0,
                child: InkWell(
                  onTap: ()=> callback(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.delete_outline, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
