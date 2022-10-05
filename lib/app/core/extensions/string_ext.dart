extension Slash on String {

  String get removeLastSlash{
    String value = this;
    if(this[length-1] == '/'){
      value = replaceRange(length-1, length, '');
      value = value.removeLastSlash;
    }
    return value;
  }
}