import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/text_widget.dart';

class ContentDialog extends StatelessWidget {
  const ContentDialog({Key? key, required this.title, required this.content, required this.actions}) : super(key: key);
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title,
            const SizedBox(height: 10),
            content,
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            )
          ],
        ),
      ),
    );
  }

}
