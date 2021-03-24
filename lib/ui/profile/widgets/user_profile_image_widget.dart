import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:flutter/material.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({this.profileImage, this.backgroundImage});

  final String profileImage;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: profileImage != null
                ? CustomImageWidget(
                    imageWidgetType: ImageWidgetType.network,
                    imageUrl: profileImage,
                  )
                : Container(color: Colors.blue),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey[200],
              child: backgroundImage != null
                  ? CustomImageWidget(
                      imageWidgetType: ImageWidgetType.network,
                      imageUrl: profileImage,
                    )
                  : const Icon(Icons.person, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
