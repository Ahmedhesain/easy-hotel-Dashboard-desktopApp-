import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      this.text, {
        Key? key,
        this.textColor,
        this.size,
        this.weight,
        this.textAlign,
        this.children,
        // this.showUnderline,
        // this.showInline,
        this.onTap,
        this.maxLines,
        this.textDirection,
        this.height,
      }) : super(key: key);
  final String text;
  final Color? textColor;
  final double? size;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final List<TextWidget>? children;
  final Function()? onTap;
  // final bool? showUnderline;
  // final bool? showInline;
  final int? maxLines;
  final double? height;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(text: text.tr,
          children: (children??[])
              .map((e) => TextSpan(text: e.text.tr,style: TextStyle(
            color: e.textColor,
            fontSize: e.size,
            fontWeight: e.weight,
            // decoration: (e.showUnderline??false) ? TextDecoration.underline : (e.showInline??false)?TextDecoration.lineThrough:TextDecoration.none,
          ),recognizer: TapGestureRecognizer()..onTap = e.onTap)).toList(),
          recognizer: TapGestureRecognizer()..onTap = onTap
      ),
      textDirection: textDirection,
      key: key,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor,
          height: height,
          fontSize: size,
          fontWeight: weight,
          // decoration: (showUnderline??false) ? TextDecoration.underline : (showInline??false)?TextDecoration.lineThrough:null
      ),
      maxLines: maxLines,
      overflow: maxLines==null?null:TextOverflow.ellipsis,
    );
  }
}
