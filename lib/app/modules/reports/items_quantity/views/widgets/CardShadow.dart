import 'package:flutter/material.dart';

class CardShadow extends StatelessWidget {
  final Widget child;
  final double ? height,   width;
  const   CardShadow({Key?  key, required this.child, this.height,   this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange , width: 1),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400 ,

              blurRadius: 6.0,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}