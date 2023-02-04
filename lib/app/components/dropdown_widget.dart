
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/text_widget.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_constants.dart';

class DropDownWidget<T> extends StatelessWidget {

  final List<DropdownMenuItem<T>>? items;
  final String? hint;
  final dynamic value;
  final ValueChanged<dynamic>? onChanged;
  final double? rightPadding;
  final double? leftPadding;
  final double? topPadding;
  final bool isDense;
  final bool expanded;
  final bool? hideBorder;
  final bool hideErrorText;
  final String? Function(dynamic)? validator;

  const DropDownWidget({
    Key? key,
    this.hint,
    this.onChanged,
    this.value,
    this.leftPadding,
    this.rightPadding,
    this.topPadding,
    this.items,
    this.validator,
    this.isDense = false,
    this.expanded = false,
    this.hideErrorText = false,
    this.hideBorder = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = hideBorder == false ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radius/2),
      borderSide: BorderSide(color: Colors.grey , width: 1),
    ) : InputBorder.none;
    final decoration = InputDecoration(
      border: border,
      isDense: isDense,
      errorStyle: hideErrorText?TextStyle(height: 0,color: Colors.transparent):null,
      disabledBorder: border,
      enabledBorder: border,
      fillColor: Colors.white,
      focusedBorder: border,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0, right: rightPadding ?? 0, left: leftPadding ?? 0),
      child: DropdownButtonFormField<T>(
        value: value,
        validator: validator,
        decoration: decoration,
        isDense: true,
        hint: TextWidget(hint??""),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        elevation: 16,
        onChanged: onChanged,
        isExpanded: expanded,
        items: items,
      ),
    );
  }
}
