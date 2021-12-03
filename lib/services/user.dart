import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future changeUserInformation({String? username, String? fileName}) async {
    String status = 'failed';
    try {
      QuerySnapshot _snapshot = await _users
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      String id = _snapshot.docs[0].id.toString();
      if (fileName != null && username != null) {
        _users
            .doc(id)
            .update({'avatar': fileName, 'username': username}).whenComplete(
                () => status = "success");
        return status;
      }
      if (fileName != null) {
        _users.doc(id).update({'avatar': fileName}).whenComplete(
            () => status = "success");
        return status;
      }
      if (username != null) {
        _users.doc(id).update({'username': username}).whenComplete(
            () => status = "success");
        return status;
      }
      return status;
    } catch (exception) {
      return status;
    }
  }

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
