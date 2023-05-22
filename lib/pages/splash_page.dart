

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pbl_application/pages/dashboard_page.dart';
import 'package:pbl_application/pages/login_page.dart';
import 'package:pbl_application/pages/student_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(child:CircularProgressIndicator(),);
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(Constants.loginStatus);
    var user = prefs.getString('user');
    Timer(const Duration(seconds: 1),(){
      if(isLogin!= null && user!=null){
        if(isLogin){
          if(user == Constants.teacher){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const DashboardPage()));
          }
          else if(user == Constants.student){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const StudentDashboard()));
          }

        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const LoginPage()));
        }
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const LoginPage()));
      }
    });

  }
}
