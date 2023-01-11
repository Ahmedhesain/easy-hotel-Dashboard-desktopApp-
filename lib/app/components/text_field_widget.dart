import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key,
    this.upLabel,
    this.label,
    this.initialValue,
    this.hint,
    this.prefix,
    this.prefixWidget,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.onSuffixClicked,
    this.nextFocusNode,
    this.focusNode,
    this.validator,
    this.suffix,
    this.obscure = false,
    this.heightBetween = 10,
    this.textInputAction,
    this.justNumbers = false,
    this.enabled = true,
    this.textInputType,
    this.controller,
    this.ltr,
    this.maxLines,
    this.contentPadding,
    this.multiLines = false,
    this.onSubmitted,
    this.hideErrorText = false,
    this.suffixIconSize ,
    this.textDirection ,
    this.textAlign =TextAlign.start,
    this.suffixIconColor
  }) : super(key: key);

  final String? upLabel;
  final String? label;
  final String? initialValue;
  final double heightBetween;
  final double? suffixIconSize;
  final EdgeInsets? contentPadding;
  final String? hint;
  final int? maxLength;
  final Color? suffixIconColor;
  final int? maxLines;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Function()? onSuffixClicked;
  final TextAlign textAlign;
  final bool obscure;
  final bool enabled;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool justNumbers;
  final bool? ltr;
  final TextDirection? textDirection;
  final bool multiLines;
  final bool hideErrorText;

  @override
  Widget build(BuildContext context) {
    final sufIcon = suffix ?? (suffixIcon != null
        ? SizedBox(
      height: 40,
      width: 40,
      child: IconButtonWidget(
        icon: suffixIcon,
        color: suffixIconColor,
        iconSize: suffixIconSize,
        onPressed: onSuffixClicked,
      ),
    ):null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(upLabel != null)
          Padding(
            padding: EdgeInsets.only(bottom: heightBetween,left: 5,right: 5),
            child: TextWidget(upLabel!,size: 15),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(prefixWidget != null)
              prefixWidget!,
            Expanded(
              child: Directionality(
                textDirection: (ltr??false)?TextDirection.ltr:TextDirection.rtl,
                child: TextFormField(
                  validator: validator,
                  maxLength: maxLength,
                  expands: multiLines,
                  initialValue: initialValue,
                  onChanged: onChanged,
                  textAlign: textAlign,
                  onFieldSubmitted: onSubmitted,
                  focusNode: focusNode,
                  enabled: enabled,
                  textDirection: textDirection,
                  maxLines: multiLines? null : (maxLines??1),
                  onEditingComplete: nextFocusNode == null ? null : () => nextFocusNode!.requestFocus(),
                  textInputAction: textInputAction,
                  style: TextStyle(height: 1.5,leadingDistribution: TextLeadingDistribution.proportional,fontSize: 15),
                  keyboardType: textInputType,
                  obscureText: obscure,
                  inputFormatters: [
                    if(justNumbers)
                      FilteringTextInputFormatter.digitsOnly
                  ],
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: hint?.tr,
                    labelText: label,
                    counterText: "",
                    errorStyle: hideErrorText?TextStyle(height: 0,color: Colors.transparent):null,
                    constraints: BoxConstraints(minHeight: 30,maxHeight: 100),
                    contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    // hintStyle: TextStyle(color: AppColors.textFieldHintColor,fontFamily: AppTheme.appFontFamily,height: 1.5,leadingDistribution: TextLeadingDistribution.even,),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    isDense: true,
                    prefix: prefix,
                    prefixIconConstraints: BoxConstraints(maxHeight: 40,minWidth: 40,minHeight: 20),
                    prefixIcon: prefixIcon,
                    suffixIconConstraints: BoxConstraints(maxHeight: 40,minHeight: 20),
                    suffixIcon: sufIcon,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
