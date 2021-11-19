import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff96060),
        title: const Text(
          "New Task",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NewTaskPageState(),
    );
  }
}

class NewTaskPageState extends StatefulWidget {
  const NewTaskPageState({Key? key}) : super(key: key);

  @override
  State<NewTaskPageState> createState() {
    return _NewTaskPageState();
  }
}

class _NewTaskPageState extends State<NewTaskPageState> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
