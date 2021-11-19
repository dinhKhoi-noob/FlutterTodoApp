import 'package:flutter/material.dart';

class NewCheckListPage extends StatelessWidget {
  const NewCheckListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff96060),
        title: const Text(
          "New Check List",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: const NewCheckListPageState(),
    );
  }
}

class NewCheckListPageState extends StatefulWidget {
  const NewCheckListPageState({Key? key}) : super(key: key);

  @override
  State<NewCheckListPageState> createState() {
    return _NewCheckListPageState();
  }
}

class _NewCheckListPageState extends State<NewCheckListPageState> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
