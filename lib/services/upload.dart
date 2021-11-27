import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../reusable/show_alert_snackbar.dart';

class UploadToFirebase {
  Future uploadImageToFirebase(File file, BuildContext context) async {
    ShowAlertSnackbar _snackbar = ShowAlertSnackbar();
    try {
      String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      Reference _reference =
          FirebaseStorage.instance.ref('user_avatar').child(timeStamp);
      await _reference.putFile(file);
      _snackbar.showSnackbar(context, "Image was uploaded");
      return timeStamp;
    } on FirebaseException catch (e) {
      if (e.code == 'canceled') {
        _snackbar.showSnackbar(context, "Action was canceled");
        return null;
      }
    }
  }
}
