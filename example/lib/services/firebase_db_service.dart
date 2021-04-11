import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDbService {
  FirebaseDatabase firebaseDb = FirebaseDatabase.instance;

  Future<void> saveQrDetails(int qrData, String qrImageurl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await firebaseDb.reference().child(prefs.getString("uid")).set(
      {
        "qrData": qrData,
        "qrImageUrl": qrImageurl,
      },
    );
  }

  Future<int> getPreviousNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DataSnapshot snapshot = await firebaseDb
        .reference()
        .child(
          prefs.getString("uid"),
        )
        .once();
    return snapshot.value["qrData"] as int;
  }
}
