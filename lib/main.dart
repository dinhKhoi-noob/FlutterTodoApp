import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/onboarding.dart';
import './pages/home_page.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _globalMessengerKey,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      theme: ThemeData(fontFamily: 'avenir'),
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
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      _navigatePage();
      setState(() {
        _initialized = true;
      });
    } catch (exception) {
      setState(() {
        _error = true;
      });
    }
  }

  void _openOnboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Onboarding();
    }));
  }

  void _openHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  void _navigatePage() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(const Duration(seconds: 3), _openHomePage);
    } else {
      Timer(const Duration(seconds: 3), _openOnboard);
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
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
