import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:randnumber_example/services/firebase_auth_service.dart';
import 'package:randnumber_example/services/local_storage_service.dart';
import 'package:randnumber_example/ui/screens/dashboard/dashboard_screen.dart';
import 'package:randnumber_example/ui/widgets/custom_button.dart';
import 'package:randnumber_example/ui/widgets/header_label.dart';
import 'package:randnumber_example/ui/widgets/input_label.dart';
import 'package:randnumber_example/ui/widgets/number_input.dart';
import 'package:randnumber_example/ui/widgets/top_bar.dart';
import 'package:randnumber_example/ui/widgets/top_circle.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _otpEditingController = TextEditingController();

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
  }

  String _validatePhoneNumber(String phoneNumber) {
    String errorMessage;
    if (phoneNumber.isEmpty) {
      errorMessage = "Phone number cannot be empty";
    } else if (phoneNumber.length != 10) {
      errorMessage = "Enter valid phone number";
    }
    return errorMessage;
  }

  Future<void> login() async {
    final loginForm = _loginFormKey.currentState;
    if (loginForm.validate()) {
      debugPrint("Login form valid");
      final String phoneNumber = _phoneEditingController.text.trim();
      final String otp = _otpEditingController.text.trim();
      debugPrint(otp);
      if (otp != null && otp.length == 6) {
        final String verificationId =
            await LocalStorageService.getStringFromLocal(
          key: "verificationId",
        );

        if (verificationId != null) {
          await firebaseAuthService.signInWithPhoneNumber(otp, verificationId);
          final String uid = await LocalStorageService.getStringFromLocal(
            key: "uid",
          );

          if (uid != null) {
            _navToDashboardScreen();
          } else {
            displaySnackBar("Invalid OTP");
          }
        } else {
          displaySnackBar("Invalid OTP");
        }
      } else if (phoneNumber.length == 10) {
        await firebaseAuthService.verifyPhoneNumber(phoneNumber);
      }
    }
  }

  void displaySnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _navToDashboardScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.black,
      ),
      child: Center(
        child: Container(
          height: 400,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputLabel(labelName: "Phone number"),
                NumberInput(
                  textEditingController: _phoneEditingController,
                  validateHandler: _validatePhoneNumber,
                ),
                const InputLabel(labelName: "OTP"),
                NumberInput(
                  textEditingController: _otpEditingController,
                ),
                CustomButton(
                  labelName: "Login",
                  onTapHandler: login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            TopBar(),
            _buildLoginForm(),
            const HeaderLabel(labelName: "Login"),
            const TopCircle(showLogoutButton: false),
          ],
        ),
      ),
    );
  }
}
