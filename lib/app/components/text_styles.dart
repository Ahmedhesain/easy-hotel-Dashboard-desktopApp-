
import 'package:flutter/material.dart';

TextStyle titleTextStyleBold(Size size , {Color? color}){
  return TextStyle(fontSize: size.width *0.047 , fontWeight: FontWeight.w800 , color: color ?? Colors.black , fontFamily: "CairoBold") ;
}

TextStyle titleTextStyleNormal(Size size , {Color? color}){
  return TextStyle(fontSize: size.width *0.047 , fontWeight: FontWeight.w500 , color: color ?? Colors.black , fontFamily: "CairoBold") ;
}

TextStyle subTitleTextStyle(Size size , {Color? color}){
  return TextStyle(fontSize: size.width *0.02 , fontWeight: FontWeight.bold , color: color ?? Colors.black , fontFamily: "Cairo" ,) ;
}

TextStyle smallTextStyleNormal(Size size , {Color? color}){
  return TextStyle(fontSize: size.width *0.01 , fontWeight: FontWeight.normal , color: color ?? Colors.black , fontFamily: "Cairo") ;
}

TextStyle smallTextStyleBold(Size size , {Color? color}){
  return TextStyle(fontSize: size.width *0.015 , fontWeight: FontWeight.w700 , color: color ?? Colors.black , fontFamily: "CairoBold") ;
}