import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:randnumber_example/services/local_storage_service.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) =>
          saveUserDetails(authCredential),
      verificationFailed: (FirebaseAuthException authException) =>
          onVerificationFailed(authException),
      codeSent: (String verificationId, int forceResendingToken) =>
          onCodeSent(verificationId, forceResendingToken),
      codeAutoRetrievalTimeout: (String codeAutoRetrievalTimeout) =>
          onCodeAutoRetrievalTimeOut(codeAutoRetrievalTimeout),
    );
  }

  Future<void> onVerificationFailed(FirebaseAuthException authException) async {
    debugPrint("Verification Failed: ${authException.message}");
  }

  Future<void> onCodeSent(
    String verificationId,
    int forceResendingToken,
  ) async {
    LocalStorageService.setStringToLocal(
      key: "verificationId",
      value: verificationId,
    );
  }

  Future<void> onCodeAutoRetrievalTimeOut(
    String codeAutoRetrievalTimeout,
  ) async {
    debugPrint("Code Auto Retrieval Timeout: $codeAutoRetrievalTimeout");
  }

  Future<void> signInWithPhoneNumber(
      String smsCode, String verificationId) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    if (authCredential != null) {
      await saveUserDetails(authCredential);
    }
  }

  Future<void> saveUserDetails(AuthCredential authCredential) async {
    final UserCredential userCredential = await auth.signInWithCredential(
      authCredential,
    );

    if (authCredential != null) {
      LocalStorageService.setStringToLocal(
        key: "uid",
        value: userCredential.user.uid,
      );
    }
  }

  void logout() {
    auth.signOut();
    LocalStorageService.clearLocalStorage();
  }
}
