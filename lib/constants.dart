// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;

class Constants {
  static Color primary = const Color(0xff00ffe4);
  static Color deepJungleGreen = const Color(0xff007871);
  static Color background = const Color(0xffEBFFFE);
  static const String loginStatus = 'Login_Status';
  static const String teachName = 'teach_name';
  static const String studName = 'stud_name';
  static const String studId = 'stud_id';
  static const String user = 'user';
  static const String teacher = 'teacher';
  static const String student = 'student';

  static final emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}

class BarChartModel {
  String date;
  int attendance;
  final charts.Color color;

  BarChartModel({
    required this.date,
    required this.attendance,
    required this.color,
  });
}

class StudentModel {
  String rollno;
  String name;
  String email;
  String phoneNo;
  String avgAttendance;
  
  StudentModel({
    required this.rollno,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.avgAttendance,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollno': rollno,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'avgAttendance': avgAttendance,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      rollno: map['rollno'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNo: map['phoneNo'] as String,
      avgAttendance: map['avgAttendance'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
