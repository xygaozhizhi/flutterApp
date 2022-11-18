import 'package:flutter/material.dart';

class HollowFrameText extends StatelessWidget {
  final Color color;
  final double radius;
  final Color slideColor;
  final EdgeInsetsGeometry? padding;
  final Color textColor;
  final double textSize;
  final String text;

  const HollowFrameText({
    super.key,
    this.color = Colors.white,
    this.radius = 0,
    this.slideColor = Colors.black,
    this.padding,
    this.textColor = Colors.black,
    this.textSize = 14,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: slideColor,
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
