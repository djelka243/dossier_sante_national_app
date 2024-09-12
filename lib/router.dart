

import 'package:dossier_medical/views/authentification/signup.dart';
import 'package:dossier_medical/views/authentification/verification.dart';
import 'package:dossier_medical/views/home.dart';
import 'package:flutter/material.dart';

import 'views/authentification/signin.dart';

class Routers{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Authentification());
      case '/verificationSMS':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(builder: (_) => VerificationId());
        }
        return _errorRoute();
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Page introuvable'),
        ),
      ),
    );
  }
}