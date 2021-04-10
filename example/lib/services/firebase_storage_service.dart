import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseStorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  uploadImage(String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var snapshot = await firebaseStorage
        .ref()
        .child(prefs.getString("uid"))
        .putFile(File(filePath))
        .onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
