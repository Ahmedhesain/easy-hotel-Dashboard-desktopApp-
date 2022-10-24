import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({Key? key, required this.children, required this.minimumWidth, this.padding, this.textDirection}) : super(key: key);
  final List<Widget> Function(bool isScroll) children;
  final double minimumWidth;
  final EdgeInsetsGeometry? padding;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return LayoutBuilder(
      builder: (context, constraint){
        if(constraint.maxWidth > minimumWidth){
          return Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(textDirection: textDirection, children: children(false)),
          );
        } else {
          return Scrollbar(
            // thumbVisibility: true,
            controller: controller,
            thickness: 4,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              padding: padding,
              child: Row(textDirection: textDirection, children: children(true)),
            ),
          );
        }
      },
    );
  }
}
