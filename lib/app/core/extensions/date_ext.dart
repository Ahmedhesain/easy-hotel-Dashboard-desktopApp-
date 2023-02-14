extension DayFromBegin on DateTime {

  DateTime get dayFromStart{
    DateTime value = this;
    DateTime time = DateTime(value.year , value.month , value.day , 00 , 00 , 00);
    value = time;
    return value;
  }

  DateTime get dayToEnd{
    DateTime value = this;
    DateTime time = DateTime(value.year , value.month , value.day , 23 , 59 , 59);
    value = time;
    return value;
  }

}
