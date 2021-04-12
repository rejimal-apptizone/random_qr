import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randnumber_example/services/firebase_auth_service.dart';
import 'package:randnumber_example/ui/screens/dashboard/dashboard_screen.dart';
import 'package:randnumber_example/ui/screens/login/login_screen.dart';

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService firebaseAuthService = Provider.of(context);
    return firebaseAuthService.isAuthenticated
        ? DashboardScreen()
        : LoginScreen();
  }
}
