import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  final String labelName;

  const HeaderLabel({
    @required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 50,
        margin: const EdgeInsets.only(top: 75),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xFF11A3FF),
        ),
        child: Center(
          child: Text(
            labelName.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
