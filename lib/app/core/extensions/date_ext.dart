import 'package:intl/intl.dart';
extension DayFromBegin on DateTime {

  DateTime get getDayFromBegin{
    DateTime value = this;
    value = DateTime.tryParse(DateFormat("yyyy:MM:dd 00:00:00").format(value)) ?? this;
    return value;
  }

}

extension DayTOEnd on DateTime {

  DateTime get setDayToEnd{
    DateTime value = this;
    DateTime time = DateTime(value.year , value.month , value.day , 23 , 59 , 59);
    value = time;
    return value;
  }

}