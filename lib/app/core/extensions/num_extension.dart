import 'package:intl/intl.dart';

extension Comma on num{

  String get withComma{
    NumberFormat numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }

  num fixed(int count){
    final string = toStringAsFixed(count);
    return num.parse(string);
  }

}