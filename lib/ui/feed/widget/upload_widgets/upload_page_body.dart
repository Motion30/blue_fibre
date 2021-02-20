import 'dart:async';
import 'dart:io';

import 'package:blue_fibre/business_logic/feed/bloc/upload_feed_bloc/upload_feed_bloc.dart';
import 'package:blue_fibre/ui/feed/widget/upload_widgets/image_list_widget.dart';
import 'package:blue_fibre/ui/feed/widget/upload_widgets/upload_feed_loading_widget.dart';
import 'package:blue_fibre/ui/shared_widgets/custom_constant_widget.dart';
import 'package:blue_fibre/utils/media_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'empty_image_widget.dart';

class UploadBodyWidget extends StatefulWidget {
  const UploadBodyWidget({this.size});

  final Size size;

  @override
  _UploadBodyWidgetState createState() => _UploadBodyWidgetState();
}

class _UploadBodyWidgetState extends State<UploadBodyWidget> {
  final ValueNotifier<List<File>> imageList = ValueNotifier<List<File>>(<File>[]);

  final TextEditingController textController = TextEditingController();
  final StreamController<String> uploadReportStream =
      StreamController<String>.broadcast();

  Future<void> getImage() async {
    final MediaHelper media = GetIt.instance.get<MediaHelper>();
    imageList.value = await media.getImage();
  }

  @override
  void dispose() {
    uploadReportStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            imageBox(),
            const SizedBox(height: 50),
            form(),
          ],
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomTextField(
          title: 'Say Whats On Your Mind',
          controller: textController,
          length: 0,
          maxLine: null,
          keyboardType: TextInputType.multiline,
          inputBorder: const UnderlineInputBorder(),
        ),
        const SizedBox(height: 20),
        BlocConsumer<UploadFeedBloc, UploadFeedState>(
          listener: (BuildContext context, UploadFeedState state) {
            if (state is ErrorUploadFeedState) {
              CustomWarningDialog.showCustomDialog(
                context: context,
                title: 'Warning',
                message: state.message,
              );
            } else if (state is LoadedUploadFeedState) {
              imageList.value = <File>[];
              textController.clear();
            }
          },
          builder: (BuildContext context, UploadFeedState state) {
            if (state is LoadingUploadFeedState) {
              return UploadLoadingWidget(uploadReport: uploadReportStream);
            } else {
              return CustomButton(
                onPress: () {
                  if (imageList.value.isNotEmpty) {
                    context.read<UploadFeedBloc>().add(
                          UploadNewFeedPostEvent(
                            uploadStreamReport: uploadReportStream,
                            images: imageList.value,
                            des: textController.text.trim(),
                          ),
                        );
                  }
                },
                size: widget.size,
                title: 'Post',
              );
            }
          },
        ),
      ],
    );
  }

  Widget imageBox() {
    return ValueListenableBuilder<List<File>>(
      valueListenable: imageList,
      builder: (_, List<File> images, Widget child) {
        if (images.isEmpty) {
          return InkWell(
            onTap: getImage,
            child: const UploadEmptyImageWidget(),
          );
        } else {
          return UploadImageListWidget(
            imageList: imageList.value,
            callback: (int index) {
              imageList.value = List<File>.from(imageList.value)
                ..removeAt(index);
            },
          );
        }
      },
    );
  }
}
