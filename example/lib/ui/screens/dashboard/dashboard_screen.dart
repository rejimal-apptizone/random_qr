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

  _getPreviousNumber() async {
    int previousNumber = await firebaseDbService.getPreviousNumber();
    if (previousNumber != null) {
      setState(() {
        _previousNumber = previousNumber;
      });
    }
  }

  _saveQrDetails() async {
    if (_randomNumber != null) {
      String path = await _createQrImage();
      String qrImageurl = await firebaseStorageService.uploadImage(path);
      await firebaseDbService.saveQrDetails(_randomNumber, qrImageurl);
      setState(() {
        _previousNumber = _randomNumber;
      });
      _getRandomNumber();
    }
  }

  _createQrImage() async {
    final qrValidationResult = QrValidator.validate(
      data: _randomNumber.toString(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    final painter = QrPainter.withQr(
      qr: qrValidationResult.qrCode,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );

    Directory tempDir = await getApplicationSupportDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData, path);
    return path;
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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
            PreviousQrNumber(previousNumber: _previousNumber),
            Container(
              margin: EdgeInsets.only(
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
