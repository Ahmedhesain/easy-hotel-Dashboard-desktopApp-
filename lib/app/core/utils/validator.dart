
class AppValidator{

  static bool isPhoneValidate(String number){
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(number)) {
      return true;
    }
    return false;
  }

  static String? forceValue(dynamic value){
    if(value == null){
      return "الحقل مطلوب";
    }
    if(value is String && value.isEmpty){
      return "الحقل مطلوب";
    }
    return null;
  }



}