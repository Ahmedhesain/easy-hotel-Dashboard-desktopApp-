import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../core/values/app_colors.dart';
import 'image_preview.dart';


class ImageWidget extends StatelessWidget {

   ImageWidget({
    Key? key,
    required this.path,
    this.tag,
    this.secondPath,
    this.fit = BoxFit.fitWidth,
    this.keepOriginalColor,
    this.radius,
    this.color,
    this.backgroundColor,
    this.width,
    this.height,
    this.border,
    this.onPressed,
    this.elevation = 0,
    this.isCircle = false,
    this.disablePreview = true,
    this.isProfile = false,
  }) :super(key: key);

  final String path;
  final double elevation;
  final dynamic tag;
  final String? secondPath;
  final Color? color;
  final Color? backgroundColor;
  final bool? keepOriginalColor;
  final BoxFit fit;
  final double? radius;
  final double? width;
  final double? height;
  final bool isCircle;
  final Border? border;
  bool disablePreview;
  final bool isProfile;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if(path.contains("http")) {
      child = CachedNetworkImage(imageUrl: path,fit: fit,height: height,width: width,color: color,
        errorWidget: (_,__ , ___){
          return SizedBox(
            width: width,
              height: height,
              child: Image.asset(AppAssets.placeHolderImg , fit: fit,),
          );
        },
        placeholder:  (_,__){
          return LayoutBuilder(
              builder: (context,c) {
                disablePreview = true;
                return Container(color: AppColors.grey.withOpacity(.5));
              }
          );
        }
      );
    } else if(path.startsWith("/data")){
      child = Image.file(File(path),color: color,width: width,height: height,fit: fit,);
    } else if(path.split(".").last == "svg"){
      child = SvgPicture.asset(path,color: color,width: width,height: height,fit: fit,);
    } else {
      child = Image.asset(path, color: color,width: width,height: height,fit: fit,);
    }
    if(tag != null){
      child = Hero(tag: tag, child: child);
    }
    return GestureDetector(
      onTap: (disablePreview && onPressed == null)?null:(){
        if(onPressed != null) {
          onPressed!();
        } else {
          Get.to(() => ImagePreviewWidget(path: path,tag: tag));
        }
      },
      child: Container(
        width: width,
        height: height,
        foregroundDecoration:BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          border: border,
          borderRadius: isCircle?null: BorderRadius.all(Radius.circular( radius ?? AppConstants.radius)),
          color: Colors.transparent,
      ),
        decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            border: border,
            borderRadius: isCircle?null: BorderRadius.all(Radius.circular( radius ?? AppConstants.radius)),
            color: backgroundColor,
            boxShadow: [
            if(elevation > 0)
          BoxShadow(color: Colors.black26,spreadRadius: elevation, blurRadius: elevation*3)
        ]
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}