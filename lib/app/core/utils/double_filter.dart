import 'package:flutter/services.dart';

FilteringTextInputFormatter get doubleInputFilter => FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)$'));
