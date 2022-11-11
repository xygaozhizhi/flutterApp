import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({Key? key}) : super(key: key);

  @override
  State<SystemPage> createState() => _SystemState();
}

class _SystemState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("system"),
    );
  }

}