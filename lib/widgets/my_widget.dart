import 'package:flutter/material.dart';

class HollowFrameText extends StatelessWidget {
  final Color color;

  const HollowFrameText({
    super.key,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
      ),
      child: Text("date"),
    );
  }
}
