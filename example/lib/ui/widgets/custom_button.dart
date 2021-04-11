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
        margin: const EdgeInsets.only(top: 40),
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xFF3E3E3E),
        ),
        child: Center(
          child: Text(
            labelName.toUpperCase(),
            style: const TextStyle(
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
