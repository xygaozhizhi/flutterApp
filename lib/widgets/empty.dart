import 'package:flutter/cupertino.dart';

class EmptyPage extends StatelessWidget {
  final String tipMsg;

  const EmptyPage({super.key, required this.tipMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(tipMsg),
    );
  }
}
