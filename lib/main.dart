import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pbl_application/constants.dart';
import 'package:pbl_application/pages/dashboard_page.dart';
import 'package:pbl_application/pages/login_page.dart';
import 'package:pbl_application/pages/registration_page.dart';
import 'package:pbl_application/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
