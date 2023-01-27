import 'package:flutter/material.dart';
import 'package:notch_dental/screens/dentist/DentistHome.dart';
import 'package:notch_dental/screens/dentist/DentistLogin.dart';
import 'package:notch_dental/screens/dentist/DentistSignup.dart';
import 'package:notch_dental/screens/FailedAuthentication.dart';
import 'package:notch_dental/screens/LandingPage.dart';
import 'package:notch_dental/screens/Login.dart';
import 'package:notch_dental/screens/Signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notch Dental',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/':(context) =>LandingPage(),
        '/dentist-login':(context) =>DentistLogin(),
        '/dentist-signup':(context) =>DentistSignup(),
        '/dentist-home':(context) =>DentistHome(),
        '/login':(context) =>Login(),
        '/signup':(context) =>Signup(),
        '/failed-authentication':(context) =>FailedAuthentication(),
      },
    );
  }
}
