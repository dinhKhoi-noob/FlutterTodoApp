import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
      home: const ForgotPasswordPageState(),
    );
  }
}

class ForgotPasswordPageState extends StatefulWidget {
  const ForgotPasswordPageState({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPageState> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          Text("Hello world")
        ]
      ,),
    );
  }
}
