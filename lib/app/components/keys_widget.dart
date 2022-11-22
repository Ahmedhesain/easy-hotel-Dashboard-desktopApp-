import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeysWidget extends StatelessWidget {
  const KeysWidget({Key? key, required this.child, required this.enabled, this.saveFunc, this.newFunc, this.printFunc, this.printJournalFunc}) : super(key: key);
  final Widget child;
  final bool enabled;
  final void Function()? saveFunc;
  final void Function()? newFunc;
  final void Function()? printFunc;
  final void Function()? printJournalFunc;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
        autofocus: true,
        onKeyEvent: (focusNode, keyEvent){
          if(enabled){
            if(keyEvent.logicalKey == LogicalKeyboardKey.f5){
              saveFunc?.call();
            } else if(keyEvent.logicalKey == LogicalKeyboardKey.f6){
              newFunc?.call();
            } else if(keyEvent.logicalKey == LogicalKeyboardKey.f7){
              printFunc?.call();
            } else if(keyEvent.logicalKey == LogicalKeyboardKey.f8){
              printJournalFunc?.call();
            } else {
              return KeyEventResult.ignored;
            }
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;

        },
        child: child
    );
  }
}
