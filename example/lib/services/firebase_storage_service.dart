import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseStorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(String filePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final snapshot = await firebaseStorage
        .ref()
        .child(prefs.getString("uid"))
        .putFile(File(filePath))
        .onComplete;
    final downloadUrl = await snapshot.ref.getDownloadURL() as String;
    return downloadUrl;
  }
}
