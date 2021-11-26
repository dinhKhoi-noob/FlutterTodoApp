import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class UserService {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');
  Future addUser(String username, String password, String email) async {
    try {
      _users.add({
        'username': username,
        'email': email.toLowerCase(),
        'id': randomString(10),
        'password': password,
        'avatar': 'default'
      });
      return "success";
    } catch (exception) {
      return "Enternal server error!";
    }
  }
}
