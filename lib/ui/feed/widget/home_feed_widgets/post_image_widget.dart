import 'package:blue_fibre/ui/shared_widgets/custom_image_widget.dart';
import 'package:blue_fibre/utils/eums.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class PostImageWidget extends StatelessWidget {
  const PostImageWidget({Key key, this.imageList}) : super(key: key);
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: imageList.length > 1
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Carousel(
                autoplay: false,
                images: imageList
                    .map((String imageUlr) => CustomImageWidget(
                          imageWidgetType: ImageWidgetType.network,
                          imageUrl: imageUlr,
                          boxFit: BoxFit.cover,
                        ))
                    .toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.black,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.grey.withOpacity(0.5),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CustomImageWidget(
                imageWidgetType: ImageWidgetType.network,
                imageUrl: imageList.first,
                boxFit: BoxFit.contain,
              ),
            ),
    );
  }
}
