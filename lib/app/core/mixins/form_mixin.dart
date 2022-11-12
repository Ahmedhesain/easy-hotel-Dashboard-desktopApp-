import 'package:flutter/cupertino.dart';

mixin FormMixin{

  GlobalKey<FormState>? _form;
  TextEditingController? _textFieldController1;
  TextEditingController? _textFieldController2;
  TextEditingController? _textFieldController3;
  TextEditingController? _textFieldController4;
  TextEditingController? _textFieldController5;
  TextEditingController? _textFieldController6;
  TextEditingController? _textFieldController7;
  TextEditingController? _textFieldController8;
  FocusNode? _focusNode1;
  FocusNode? _focusNode2;
  FocusNode? _focusNode3;
  FocusNode? _focusNode4;
  FocusNode? _focusNode5;
  FocusNode? _focusNode6;
  FocusNode? _focusNode7;
  FocusNode? _focusNode8;

  GlobalKey<FormState> get form{
    _form ??= GlobalKey<FormState>();
    return _form!;
  }

  TextEditingController get textFieldController1{_textFieldController1 ??= TextEditingController(); return _textFieldController1!;}
  TextEditingController get textFieldController2{_textFieldController2 ??= TextEditingController(); return _textFieldController2!;}
  TextEditingController get textFieldController3{_textFieldController3 ??= TextEditingController(); return _textFieldController3!;}
  TextEditingController get textFieldController4{_textFieldController4 ??= TextEditingController(); return _textFieldController4!;}
  TextEditingController get textFieldController5{_textFieldController5 ??= TextEditingController(); return _textFieldController5!;}
  TextEditingController get textFieldController6{_textFieldController6 ??= TextEditingController(); return _textFieldController6!;}
  TextEditingController get textFieldController7{_textFieldController7 ??= TextEditingController(); return _textFieldController7!;}
  TextEditingController get textFieldController8{_textFieldController8 ??= TextEditingController(); return _textFieldController8!;}

  FocusNode get focusNode1{_focusNode1 ??= FocusNode(); return _focusNode1!;}
  FocusNode get focusNode2{_focusNode2 ??= FocusNode(); return _focusNode2!;}
  FocusNode get focusNode3{_focusNode3 ??= FocusNode(); return _focusNode3!;}
  FocusNode get focusNode4{_focusNode4 ??= FocusNode(); return _focusNode4!;}
  FocusNode get focusNode5{_focusNode5 ??= FocusNode(); return _focusNode5!;}
  FocusNode get focusNode6{_focusNode6 ??= FocusNode(); return _focusNode6!;}
  FocusNode get focusNode7{_focusNode7 ??= FocusNode(); return _focusNode7!;}
  FocusNode get focusNode8{_focusNode8 ??= FocusNode(); return _focusNode8!;}
}