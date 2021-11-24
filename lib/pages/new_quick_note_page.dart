import 'package:flutter/material.dart';

class NewQuickNotePage extends StatelessWidget {
  const NewQuickNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff96060),
        title: const Text(
          "New Quick Note",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NewQuickNotePageState(),
    );
  }
}

class NewQuickNotePageState extends StatefulWidget {
  const NewQuickNotePageState({Key? key}) : super(key: key);

  @override
  State<NewQuickNotePageState> createState() {
    return _NewQuickNotePageState();
  }
}

class _NewQuickNotePageState extends State<NewQuickNotePageState> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
