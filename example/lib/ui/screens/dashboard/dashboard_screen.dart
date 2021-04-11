import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:randnumber/randnumber.dart';
import 'package:randnumber_example/services/firebase_auth_service.dart';
import 'package:randnumber_example/services/firebase_db_service.dart';
import 'package:randnumber_example/services/firebase_storage_service.dart';
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
  FirebaseDbService firebaseDbService = FirebaseDbService();
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  int _randomNumber;
  int _previousNumber;

  @override
  void initState() {
    super.initState();
    _getPreviousNumber();
    _getRandomNumber();
  }

  Future<void> _getPreviousNumber() async {
    final int previousNumber = await firebaseDbService.getPreviousNumber();
    if (previousNumber != null) {
      setState(() {
        _previousNumber = previousNumber;
      });
    }
  }

  Future<void> _saveQrDetails() async {
    if (_randomNumber != null) {
      final String path = await _createQrImage();
      final String qrImageurl = await firebaseStorageService.uploadImage(path);
      await firebaseDbService.saveQrDetails(_randomNumber, qrImageurl);
      setState(() {
        _previousNumber = _randomNumber;
      });
      _getRandomNumber();
    }
  }

  Future<String> _createQrImage() async {
    final qrValidationResult = QrValidator.validate(
      data: _randomNumber.toString(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    final painter = QrPainter.withQr(
      qr: qrValidationResult.qrCode,
      color: const Color(0xFF000000),
      gapless: true,
    );

    final Directory tempDir = await getApplicationSupportDirectory();
    final String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final String path = '$tempPath/$ts.png';

    final picData = await painter.toImageData(
      2048,
      format: ImageByteFormat.png,
    );
    await writeToFile(picData, path);
    return path;
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> logout() async {
    firebaseAuthService.logout();
    await _clearLocalStorage();
    _navToLoginScreen();
  }

  void _navToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }

  Future<void> _clearLocalStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<void> _getRandomNumber() async {
    int randomNumber;

    randomNumber = await Randnumber.getRandom;
    debugPrint(randomNumber.toString());
    if (!mounted) return;

    setState(() {
      _randomNumber = randomNumber;
    });
  }

  Widget _buildQrContainer() {
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
      child: Container(
        height: 400,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GeneratedQrNumber(
              randomNumber: _randomNumber.toString(),
            ),
            PreviousQrNumber(previousNumber: _previousNumber),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 100,
              ),
              child: CustomButton(
                labelName: "Save",
                onTapHandler: () => _saveQrDetails(),
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
            const HeaderLabel(labelName: "Plugin"),
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
