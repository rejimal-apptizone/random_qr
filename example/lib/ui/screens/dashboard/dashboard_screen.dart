import 'package:flutter/material.dart';
import 'package:randnumber/randnumber.dart';
import 'package:randnumber_example/services/firebase_auth_service.dart';
import 'package:randnumber_example/ui/screens/login/login_screen.dart';
import 'package:randnumber_example/ui/widgets/custom_button.dart';
import 'package:randnumber_example/ui/widgets/generated_qr_number.dart';
import 'package:randnumber_example/ui/widgets/header_label.dart';
import 'package:randnumber_example/ui/widgets/previous_qr_number.dart';
import 'package:randnumber_example/ui/widgets/top_bar.dart';
import 'package:randnumber_example/ui/widgets/top_circle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  int _randomNumber;

  @override
  void initState() {
    super.initState();

    _getRandomNumber();
  }

  logout() async {
    firebaseAuthService.logout();
    await _clearLocalStorage();
    _navToLoginScreen();
  }

  _navToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }

  _clearLocalStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<void> _getRandomNumber() async {
    int randomNumber;

    randomNumber = await Randnumber.getRandom;
    print(randomNumber);
    if (!mounted) return;

    setState(() {
      _randomNumber = randomNumber;
    });
  }

  Widget _buildQrContainer() {
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
      child: Container(
        height: 400,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GeneratedQrNumber(
              randomNumber: _randomNumber.toString(),
            ),
            PreviousQrNumber(),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: CustomButton(
                labelName: "Save",
                onTapHandler: () => _getRandomNumber(),
              ),
            ),
          ],
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
            _buildQrContainer(),
            HeaderLabel(labelName: "Plugin"),
            TopCircle(
              showLogoutButton: true,
              onTapHandler: logout,
            ),
          ],
        ),
      ),
    );
  }
}
