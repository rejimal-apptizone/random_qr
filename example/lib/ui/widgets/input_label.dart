import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String labelName;

  const InputLabel({
    @required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      labelName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
