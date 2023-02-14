import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';


import '../core/utils/common.dart';
import '../core/values/app_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key,
    this.text,
    this.onPressed,
    this.svgPath,
    this.buttonColor,
    this.fontColor,
    this.fontSize,
    this.isOutlined = false,
    this.icon,
    this.expanded = false,
    this.contentPadding,
    this.margin = EdgeInsets.zero,
    this.width,
    this.height,
    this.radius = AppConstants.radius,
    this.textDirection,
    this.isLoading = false,
  }) : assert(!(svgPath != null && icon != null)), super(key: key);

  final Function()? onPressed;
  final String? text;
  final String? svgPath;
  final Color? buttonColor;
  final Color? fontColor;
  final bool expanded;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final EdgeInsets? contentPadding;
  final EdgeInsets margin;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return Center(child: Common.getSpin());
    }
    final child = Row(
      textDirection: textDirection,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if(icon != null)
          Icon(icon),
        if((svgPath != null || icon != null) && text != null)
          const SizedBox(width: 10),
        if(text != null)
          Text(text!.tr,style: TextStyle(fontSize: fontSize,height: 1)),
      ],
    );
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: margin,
        child: Builder(
            builder: (context) {
              if(isOutlined) {
                return OutlinedButton(
                    onPressed: onPressed,
                    style: OutlinedButton.styleFrom(
                        foregroundColor: fontColor,
                        // side: BorderSide(color: buttonColor ?? AppColors.colorYellow,width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius)
                        ),
                        shadowColor: Colors.transparent,
                        padding: contentPadding ?? const EdgeInsets.all(15)
                    ),
                    child: child
                );
              }
              return ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: fontColor ?? Colors.black,
                      // backgroundColor: buttonColor ?? AppColors.colorYellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius)
                      ),
                      shadowColor: Colors.transparent,
                      padding: contentPadding ?? const EdgeInsets.all(15)
                  ),
                  child: child
              );
            }
        ),
      ),
    );
  }
}
