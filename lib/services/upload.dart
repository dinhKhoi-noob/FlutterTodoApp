import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../reusable/show_alert_snackbar.dart';

class UploadToFirebase {
  Future uploadImageToFirebase(File file, BuildContext context) async {
    ShowAlertSnackbar _snackbar = ShowAlertSnackbar();
    try {
      String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      String? downloadURL;
      Reference _reference =
          FirebaseStorage.instance.ref('user_avatar').child(timeStamp);
      await _reference.putFile(file).then((p0) async {
        await FirebaseStorage.instance
            .ref('user_avatar')
            .child(timeStamp)
            .getDownloadURL()
            .then((value) {
          downloadURL = value;
          print("success");
        });
      });
      return downloadURL;
    } on FirebaseException catch (e) {
      if (e.code == 'canceled') {
        _snackbar.showSnackbar(context, "Action was canceled");
        return null;
      }
    } catch (exception) {
      _snackbar.showSnackbar(context, "Something went wrong");
      return null;
    }
  }
}
