import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:randnumber/randnumber.dart';
import 'package:randnumber_example/ui/screens/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        body: DashboardScreen(),
      ),
    );
  }
}
