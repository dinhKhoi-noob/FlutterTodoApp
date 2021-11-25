import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Weak password";
      } else if (e.code == 'email-already-in-use') {
        return "Email already in use";
      }
    } catch (exception) {
      return "Something went wrong";
    }
  }

  Future signinAccount(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found!";
      } else if (e.code == 'wrong-password') {
        return "Incorrect email or password!";
      }
    } catch (exception) {
      // ignore: avoid_print
      print(exception);
      return "Enternal server error!";
    }
  }

  Future signoutAccount() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "success";
    } catch (exception) {
      //ignore:avoid_print
      print(exception);
      return "Enternal server error!";
    }
  }
}
