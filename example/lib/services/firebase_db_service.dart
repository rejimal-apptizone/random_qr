import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDbService {
  FirebaseDatabase firebaseDb = FirebaseDatabase.instance;

  saveQrDetails(int qrData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await firebaseDb.reference().child(prefs.getString("uid")).set(
      {
        "qrData": qrData,
        "qrImageUrl": "imageUrl",
      },
    );
  }

  getPreviousNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DataSnapshot snapshot =
        await firebaseDb.reference().child(prefs.getString("uid")).once();
    return snapshot.value["qrData"] ?? null;
  }
}
