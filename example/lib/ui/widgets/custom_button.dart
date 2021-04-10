import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String labelName;
  final Function() onTapHandler;

  const CustomButton({
    @required this.labelName,
    @required this.onTapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xFF3E3E3E),
        ),
        child: Center(
          child: Text(
            labelName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
