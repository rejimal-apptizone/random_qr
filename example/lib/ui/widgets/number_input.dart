import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 20,
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Color(0xFF2E2B60), width: 2.0),
          ),
          filled: true,
          fillColor: Color(0xFF2E2B60),
        ),
      ),
    );
  }
}
