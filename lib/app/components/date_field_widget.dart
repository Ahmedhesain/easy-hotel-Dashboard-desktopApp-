import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toby_bills/app/components/text_widget.dart';

class DateFieldWidget extends StatefulWidget {
  const DateFieldWidget({Key? key, required this.onComplete, this.date, this.fillColor , this.hideBorder , this.label , this.formKey , this.validate , this.isActive = true}) : super(key: key);
  final Function(DateTime date) onComplete;
  final DateTime? date;
  final Color? fillColor;
  final bool? hideBorder;
  final String? label;
  final GlobalKey? formKey ;
  final String? Function(String? value)? validate;
  final bool? isActive ;
  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {

  final controller = TextEditingController();

  List<String> oldDigits = [];
  String oldValue = "";

  @override
  void initState() {
    super.initState();
    if(widget.date != null){
      controller.text = widget.date!.toIso8601String().split("T").first.replaceAll("-", "/").split("/").reversed.join("/");
    }
  }

  @override
  void didUpdateWidget(covariant DateFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.date != null){
      controller.text = widget.date!.toIso8601String().split("T").first.replaceAll("-", "/").split("/").reversed.join("/");
    }
  }

  bool isDaysInMonthValid(int days, int month, int year){
    return ([0,1,3,5,7,8,10,12].contains(month) && days <= 31
    || [4,6,8,11].contains(month) && days <=30
    || month == 2 && (days <= 28 || (year%4==0 && days == 29)));
  }

  bool isValid(String value){
    final characters = value.split("");
    List<String> sections = value.split("/");
    sections.removeWhere((element) => element.isEmpty);
    if(sections.isEmpty) sections.addAll(["01","01","2022"]);
    if(sections.length == 1) sections.addAll(["01","2022"]);
    if(sections.length == 2) sections.addAll(["2020"]);
    int? day = int.parse(sections[0]);
    int? month = int.parse(sections[1]);
    int? year = int.parse(sections[2]);
    if(!isDaysInMonthValid(day, month, year)){
      return false;
    }
    sections = sections.reversed.toList();
    for(var i = 0; i< sections.length; i++){
      if(i == 0 && sections[i].length > 4){
        return false;
      }
      if(i == 2 && (sections[i].length > 2 || int.parse(sections[i]) > 31)){
        return false;
      }
      if(i == 1 && (sections[i].length > 2 || int.parse(sections[i]) > 12)){
        return false;
      }
    }
    for(var i = 0; i < characters.length; i++){
      if(characters.where((element) => element == "/").length > 2 || characters.first == "/"){
        return false;
      }
      if(i > 0 && characters[i] == "/" && characters[i-1] == "/"){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.ltr,
      enabled: (widget.isActive) ?? true,
      key: widget.formKey,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        border: widget.hideBorder == true ? InputBorder.none  : const OutlineInputBorder(),
        counterText: "",
        counterStyle: const TextStyle(height: 0),
        label: widget.label == null ? const SizedBox.shrink() : TextWidget(widget.label!),
        isDense: true,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor??Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12)
      ),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]|/'))],
      maxLength: 10,
      validator: widget.validate,
      onChanged: (value){
        if(value.length > 10) return;
        if((value.length == 2 || value.length == 5) && value.characters.last != "/" && value.characters.where((p) => p =="/").length < 2){
          value = "$value/";
          final oldOffset = value.length;
          controller.text = value;
          controller.selection = controller.selection.copyWith(baseOffset: oldOffset,extentOffset: oldOffset,isDirectional: true);
        }
        int oldOffset = controller.selection.extentOffset;
        if(isValid(value)){
          oldValue = value;
        } else {
          value = oldValue;
          controller.text = value;
          if(oldOffset > value.length) {
            oldOffset = value.length;
          }
          controller.selection = controller.selection.copyWith(baseOffset: oldOffset,extentOffset: oldOffset,isDirectional: true);
        }
        if(value.length > 7) {
          List<String> sections = value.replaceAll("/", "-").split("-").reversed.toList();
          String day = "";
          String month = "";
          String year = "";
          if (sections.isNotEmpty) year = sections.first.padLeft(4, "0");
          if (sections.length > 1) month = sections[1].padLeft(2, "0");
          if (sections.length > 2) day = sections[2].padLeft(2, "0");
          final date = [year, month, day].join("-");
          if (DateTime.tryParse(date) != null && DateTime.tryParse(date)!.year.toString().length>3) {
            widget.onComplete(DateTime.parse(date));
          }
        }
      },
    );
  }
}
