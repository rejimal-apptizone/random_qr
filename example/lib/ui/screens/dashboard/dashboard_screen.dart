import 'package:flutter/material.dart';
import 'package:randnumber_example/ui/widgets/custom_button.dart';
import 'package:randnumber_example/ui/widgets/generated_qr_number.dart';
import 'package:randnumber_example/ui/widgets/header_label.dart';
import 'package:randnumber_example/ui/widgets/previous_qr_number.dart';
import 'package:randnumber_example/ui/widgets/top_bar.dart';
import 'package:randnumber_example/ui/widgets/top_circle.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
            GeneratedQrNumber(),
            PreviousQrNumber(),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: CustomButton(
                labelName: "Save",
                onTapHandler: () => print("Saved"),
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
            ),
          ],
        ),
      ),
    );
  }
}
