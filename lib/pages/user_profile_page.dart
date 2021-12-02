import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import '../services/user.dart';
import '../services/upload.dart';
import '../reusable/new_screen_navigator_route.dart';
import '../reusable/show_alert_snackbar.dart';
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
  XFile? _userAvatar;
  String? _fileName;
  ImageProvider _setImageProvider() {
    if (_userAvatar != null) {
      return FileImage(File(_userAvatar!.path));
    } else {
      return const AssetImage('asset/image/user_avatar.png');
    }
  }

  void _openImagePickerFromGallary() async {
    final ImagePicker _picker = ImagePicker();
    XFile? _currentAvatar =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _userAvatar = _currentAvatar;
    });
  }

  void _showAvatar(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(image: DecorationImage(image: _setImageProvider())),
        ));
      },
    ));
  }

  void _showBottomDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1))),
                  child: InkWell(
                    onTap: () {
                      _showAvatar(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          "View avatar",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        Icon(Icons.account_box_outlined, size: 30)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1))),
                  child: InkWell(
                    onTap: () {
                      _openImagePickerFromGallary();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          "Choose avatar",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        Icon(Icons.image_outlined, size: 30)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _onSaveChange({String? username}) async {
    UserService _userService = UserService();
    if (_userAvatar != null) {
      UploadToFirebase _uploadService = UploadToFirebase();
      _fileName = await _uploadService.uploadImageToFirebase(
          File(_userAvatar!.path), context);
      
      // if (_fileName != null) {
      //   if(username != null)
      //   {
      //     _userService.changeUserInformation(
      //       username: username,
      //       fileName: _fileName
      //     );
      //   }
        
      // }
    }
  }

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
                    InkWell(
                      onTap: () {
                        _showBottomDialog(context);
                      },
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:
                                  DecorationImage(image: _setImageProvider())),
                        ),
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
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: const Color(0xfff96060)),
                        child: const Text(
                          "Save change",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () {
                          UserService _userService = UserService();
                          _userService.changeUserInformation(
                              username: "", fileName: _fileName);
                        },
                      ),
                    )
                  ],
                ));
          }
          return const Text("");
        });
  }
}
