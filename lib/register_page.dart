import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPageState(),
      theme: ThemeData(fontFamily: 'avenir'),
    );
  }
}

class RegisterPageState extends StatefulWidget {
  const RegisterPageState({Key? key}) : super(key: key);

  @override
  State<RegisterPageState> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: (){},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
