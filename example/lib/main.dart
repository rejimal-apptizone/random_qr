import 'package:flutter/material.dart';
import 'dart:async';

import 'package:randnumber/randnumber.dart';

import 'ui/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _randomNumber;

  @override
  void initState() {
    super.initState();
    _getRandomNumber();
  }

  Future<void> _getRandomNumber() async {
    int randomNumber;

    randomNumber = await Randnumber.getRandom;
    if (!mounted) return;

    setState(() {
      _randomNumber = randomNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}