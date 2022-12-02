import 'package:flutter/material.dart';
import 'package:myflutterapp/widgets/my_widget.dart';

class EmptyPage extends StatelessWidget {
  final String tipMsg;
  final VoidCallback? onPressed;
  final bool needRefresh;

  const EmptyPage(
      {Key? key,
      required this.tipMsg,
      this.onPressed,
      required this.needRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: needRefresh
            ? [
                Text(tipMsg),
                TextButton(
                  onPressed: onPressed,
                  child: const HollowFrameText(
                    text: "刷新",
                    padding: EdgeInsets.all(6),
                    textColor: Colors.blueAccent,
                    slideColor: Colors.blueAccent,
                  ),
                ),
              ]
            : [
                Text(tipMsg),
              ],
      ),
    );
  }
}
