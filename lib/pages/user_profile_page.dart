import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable/show_alert_snackbar.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todoapp/reusable/new_screen_navigator_route.dart';
import '../services/authenticate.dart';
import './onboarding.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  void _openContextDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            actions: <Widget>[
              OutlinedButton(
                  onPressed: () async {
                    AuthServices _auth = AuthServices();
                    String _message = await _auth.signoutAccount();
                    if (_message != 'success') {
                      ShowAlertSnackbar _snackbar = ShowAlertSnackbar();
                      _snackbar.showSnackbar(context, _message);
                    } else {
                      Navigator.push(context,
                          NewScreenNavigatorRoute(child: const Onboarding()));
                    }
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 20),
                  )),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        });
  }

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
        actions: [
          IconButton(
              tooltip: "Sign out",
              onPressed: () {
                _openContextDialog(context, "Do you really want to sign out?");
              },
              icon: const Icon(Icons.logout_sharp))
        ],
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
  @override
  Widget build(BuildContext context) {
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<QuerySnapshot>(
        future: _users
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Map<String, dynamic>? _user;
          if (snapshot.data != null) {
            _user = snapshot.data!.docs[0].data() as Map<String, dynamic>;
          }
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData &&
              snapshot.data == null &&
              snapshot.data!.docs.isEmpty) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Loader.show(context);
          } else {
            Loader.hide();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              _user != null) {
            return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('asset/image/user_avatar.png'))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Username:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Email:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _user['username'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                _user['email'],
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ));
          }
          return const Text("");
        });
  }
}
