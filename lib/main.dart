import 'dart:async';
import 'package:flutter/material.dart';
import 'pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openOnboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Onboarding();
    }));
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), _openOnboard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/image/aking.png'))),
      )),
    );
  }
}
