import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) =>
          onVerificationCompleted(authCredential),
      verificationFailed: (FirebaseAuthException authException) =>
          onVerificationFailed(authException),
      codeSent: (String verificationId, int forceResendingToken) =>
          onCodeSent(verificationId, forceResendingToken),
      codeAutoRetrievalTimeout: (String codeAutoRetrievalTimeout) =>
          onCodeAutoRetrievalTimeOut(codeAutoRetrievalTimeout),
    );
  }

  Future<void> onVerificationCompleted(AuthCredential authCredential) async {
    final UserCredential userCredential =
        await auth.signInWithCredential(authCredential);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", userCredential.user.uid);
    debugPrint("userCredential.user.uid: ${userCredential.user.uid}");
  }

  Future<void> onVerificationFailed(FirebaseAuthException authException) async {
    debugPrint("Verification Failed: ${authException.message}");
  }

  Future<void> onCodeSent(
    String verificationId,
    int forceResendingToken,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("verificationId", verificationId);
  }

  Future<void> onCodeAutoRetrievalTimeOut(
    String codeAutoRetrievalTimeout,
  ) async {
    debugPrint("Code Auto Retrieval Timeout: $codeAutoRetrievalTimeout");
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: prefs.getString("verificationId"),
      smsCode: smsCode,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    prefs.setString("uid", userCredential.user.uid);
    debugPrint("userCredential.user.uid: ${userCredential.user.uid}");
  }

  void logout() {
    auth.signOut();
  }
}
