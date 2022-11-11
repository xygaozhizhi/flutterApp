import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("project"),
    );
  }

}