import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewWidget extends StatefulWidget {
  const ImagePreviewWidget({Key? key,required this.path, this.tag}) : super(key: key);

  final String path;
  final dynamic tag;

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {

  final controller = PhotoViewController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late ImageProvider image;
    if(widget.path.contains("http")){
      image = CachedNetworkImageProvider(widget.path);
    } else {
      image = FileImage(File(widget.path));
    }
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButtonWidget(icon: Icons.arrow_back_rounded,iconColor: AppColors.grey,onPressed: Get.back),
          backgroundColor: Colors.transparent,
        ),
        body: ColoredBox(
            color: Colors.black,
            child: PhotoView(
              heroAttributes: PhotoViewHeroAttributes(
                tag: widget.tag ?? UniqueKey()
              ),
              controller: controller,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0.0
                        : event.cumulativeBytesLoaded.toDouble() / (event.expectedTotalBytes??0),
                  ),
                ),
              ),
              imageProvider: image,
            )
        ),
      ),
    );
  }
}
