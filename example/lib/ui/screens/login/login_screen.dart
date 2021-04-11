import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:randnumber_example/services/firebase_auth_service.dart';
import 'package:randnumber_example/ui/screens/dashboard/dashboard_screen.dart';
import 'package:randnumber_example/ui/widgets/custom_button.dart';
import 'package:randnumber_example/ui/widgets/header_label.dart';
import 'package:randnumber_example/ui/widgets/input_label.dart';
import 'package:randnumber_example/ui/widgets/number_input.dart';
import 'package:randnumber_example/ui/widgets/top_bar.dart';
import 'package:randnumber_example/ui/widgets/top_circle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _otpEditingController = TextEditingController();

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
  }

  login() async {
    String phoneNumber = _phoneEditingController.text.trim();
    String otp = _otpEditingController.text.trim();
    print(phoneNumber);
    if (otp != null && otp.length == 6) {
      await firebaseAuthService.signInWithPhoneNumber(otp);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString("uid");
      if (uid != null) {
        _navToDashboardScreen();
      }
    } else if (phoneNumber.length == 10) {
      await firebaseAuthService.verifyPhoneNumber(phoneNumber);
    }
  }

  _navToDashboardScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .90,
      decoration: BoxDecoration(
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
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(labelName: "Phone number"),
              NumberInput(
                textEditingController: _phoneEditingController,
              ),
              InputLabel(labelName: "OTP"),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            TopBar(),
            _buildLoginForm(),
            HeaderLabel(labelName: "Login"),
            TopCircle(
              showLogoutButton: false,
            ),
          ],
        ),
      ),
    );
  }
}
