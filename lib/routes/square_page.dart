import 'package:flutter/material.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  State<SquarePage> createState() => _SquareState();
}

class _SquareState extends State<SquarePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("square"),
    );
  }

}