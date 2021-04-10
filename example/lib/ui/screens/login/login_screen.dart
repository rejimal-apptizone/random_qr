import 'dart:ui';

import 'package:flutter/material.dart';
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
  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.only(top: 150),
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
              NumberInput(),
              InputLabel(labelName: "OTP"),
              NumberInput(),
              CustomButton(
                labelName: "Login",
                onTapHandler: () => print("Login"),
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
