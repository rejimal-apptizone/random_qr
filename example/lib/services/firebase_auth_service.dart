import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  verifyPhoneNumber(String phoneNumber) async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      timeout: Duration(seconds: 60),
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

  onVerificationCompleted(AuthCredential authCredential) async {
    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", userCredential.user.uid);
    print("userCredential.user.uid: ${userCredential.user.uid}");
  }

  onVerificationFailed(FirebaseAuthException authException) {
    print("Verification Failed: ${authException.message}");
  }

  onCodeSent(String verificationId, int forceResendingToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("verificationId", verificationId);
  }

  onCodeAutoRetrievalTimeOut(String codeAutoRetrievalTimeout) {
    print("Code Auto Retrieval Timeout: $codeAutoRetrievalTimeout");
  }

  signInWithPhoneNumber(String smsCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    AuthCredential authCredential = PhoneAuthProvider.getCredential(
      verificationId: prefs.getString("verificationId"),
      smsCode: smsCode,
    );

    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    prefs.setString("uid", userCredential.user.uid);
    print("userCredential.user.uid: ${userCredential.user.uid}");
  }

  logout() {
    auth.signOut();
  }
}
