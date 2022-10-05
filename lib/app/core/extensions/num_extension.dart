import 'package:intl/intl.dart';

extension Comma on num{

  String get withComma{
    NumberFormat numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }

}