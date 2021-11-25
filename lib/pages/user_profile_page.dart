import 'package:flutter/material.dart';
import 'package:todoapp/animation/new_screen_navigator_route.dart';
import '../services/authenticate.dart';
import './onboarding.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff96060),
        title: const Text(
          "User Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: const UserProfilePageState(),
    );
  }
}

class UserProfilePageState extends StatefulWidget {
  const UserProfilePageState({Key? key}) : super(key: key);

  @override
  State<UserProfilePageState> createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePageState> {
  void _openSnackbar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color(0xfff96060),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: OutlinedButton(
        onPressed: () async {
          AuthServices _auth = AuthServices();
          String _message = await _auth.signoutAccount();
          if (_message != 'success') {
            _openSnackbar(_message);
          }
          else{
            Navigator.push(context, NewScreenNavigatorRoute(child: const Onboarding()));
          }
        },
        child: const Text("Sign out"),
      ),
    );
  }
}
