import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TeacherInfo {
  String teach_email_id;
  String teach_password;

  TeacherInfo({
    required this.teach_email_id,
    required this.teach_password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teach_email_id': teach_email_id,
      'teach_password': teach_password,
    };
  }

  factory TeacherInfo.fromMap(Map<String, dynamic> map) {
    return TeacherInfo(
      teach_email_id: map['teach_email_id'] as String,
      teach_password: map['teach_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherInfo.fromJson(String source) =>
      TeacherInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Teacher {
  String teach_id;
  String teach_name;
  String teach_phone_no;
  String teach_institution_code;
  String teach_email_id;
  String teach_password;
  Teacher({
    required this.teach_id,
    required this.teach_name,
    required this.teach_phone_no,
    required this.teach_institution_code,
    required this.teach_email_id,
    required this.teach_password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teach_id': teach_id,
      'teach_name': teach_name,
      'teach_phone_no': teach_phone_no,
      'teach_institution_code': teach_institution_code,
      'teach_email_id': teach_email_id,
      'teach_password': teach_password,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      teach_id: map['teach_id'] as String,
      teach_name: map['teach_name'] as String,
      teach_phone_no: map['teach_phone_no'] as String,
      teach_institution_code: map['teach_institution_code'] as String,
      teach_email_id: map['teach_email_id'] as String,
      teach_password: map['teach_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) => Teacher.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ClassModel {
  String class_id;
  String class_name;
  String class_subject;
  String class_created_date;
  String class_theme;
  String class_no_of_student;
  String teach_id;
  ClassModel({
    required this.class_id,
    required this.class_name,
    required this.class_subject,
    required this.class_created_date,
    required this.class_theme,
    required this.class_no_of_student,
    required this.teach_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'class_id': class_id,
      'class_name': class_name,
      'class_subject': class_subject,
      'class_created_date': class_created_date,
      'class_theme': class_theme,
      'class_no_of_student': class_no_of_student,
      'teach_id': teach_id,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      class_id: map['class_id'] as String,
      class_name: map['class_name'] as String,
      class_subject: map['class_subject'] as String,
      class_created_date: map['class_created_date'] as String,
      class_theme: map['class_theme'] as String,
      class_no_of_student: map['class_no_of_student'] as String,
      teach_id: map['teach_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ClassInfo {
  String class_name;
  String class_subject;
  String class_theme;
  String teach_id;

  ClassInfo({
    required this.class_name,
    required this.class_subject,
    required this.class_theme,
    required this.teach_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'class_name': class_name,
      'class_subject': class_subject,
      'class_theme': class_theme,
      'teach_id': teach_id,
    };
  }

  factory ClassInfo.fromMap(Map<String, dynamic> map) {
    return ClassInfo(
      class_name: map['class_name'] as String,
      class_subject: map['class_subject'] as String,
      class_theme: map['class_theme'] as String,
      teach_id: map['teach_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassInfo.fromJson(String source) => ClassInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class StudentInfo {
  String stud_email_id;
  String stud_password;
  StudentInfo({
    required this.stud_email_id,
    required this.stud_password,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stud_email_id': stud_email_id,
      'stud_password': stud_password,
    };
  }

  factory StudentInfo.fromMap(Map<String, dynamic> map) {
    return StudentInfo(
      stud_email_id: map['stud_email_id'] as String,
      stud_password: map['stud_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentInfo.fromJson(String source) => StudentInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Student {
  String stud_email_id;
  String stud_password;
  String stud_id;
  String stud_roll_no;
  String stud_name;
  String stud_phone_no;
  String stud_institute_code;
  Student({
    required this.stud_email_id,
    required this.stud_password,
    required this.stud_id,
    required this.stud_roll_no,
    required this.stud_name,
    required this.stud_phone_no,
    required this.stud_institute_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stud_email_id': stud_email_id,
      'stud_password': stud_password,
      'stud_id': stud_id,
      'stud_roll_no': stud_roll_no,
      'stud_name': stud_name,
      'stud_phone_no': stud_phone_no,
      'stud_institute_code': stud_institute_code,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      stud_email_id: map['stud_email_id'] as String,
      stud_password: map['stud_password'] as String,
      stud_id: map['stud_id'] as String,
      stud_roll_no: map['stud_roll_no'] as String,
      stud_name: map['stud_name'] as String,
      stud_phone_no: map['stud_phone_no'] as String,
      stud_institute_code: map['stud_institution_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source) as Map<String, dynamic>);
}

class StudClass {
  String class_id;
  String class_name;
  String class_subject;
  String class_theme;
  String teach_name;
  StudClass({
    required this.class_id,
    required this.class_name,
    required this.class_subject,
    required this.class_theme,
    required this.teach_name,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'class_id': class_id,
      'class_name': class_name,
      'class_subject': class_subject,
      'class_theme': class_theme,
      'teach_name': teach_name,
    };
  }

  factory StudClass.fromMap(Map<String, dynamic> map) {
    return StudClass(
      class_id: map['class_id'] as String,
      class_name: map['class_name'] as String,
      class_subject: map['class_subject'] as String,
      class_theme: map['class_theme'] as String,
      teach_name: map['teach_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudClass.fromJson(String source) => StudClass.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ClassSession {

  String teach_id;
  String class_id;
  String session_id;
  String qr_hash;
  
  ClassSession({
    required this.teach_id,
    required this.class_id,
    required this.session_id,
    required this.qr_hash,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teach_id': teach_id,
      'class_id': class_id,
      'session_id': session_id,
      'qr_hash': qr_hash,
    };
  }

  factory ClassSession.fromMap(Map<String, dynamic> map) {
    return ClassSession(
      teach_id: map['teach_id'] as String,
      class_id: map['class_id'] as String,
      session_id: map['session_id'] as String,
      qr_hash: map['qr_hash'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassSession.fromJson(String source) => ClassSession.fromMap(json.decode(source) as Map<String, dynamic>);

  
}


class StudAttent {
  String session_id;
  String class_id;
  String stud_id;

  StudAttent({
    required this.session_id,
    required this.class_id,
    required this.stud_id,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'session_id': session_id,
      'class_id': class_id,
      'stud_id': stud_id,
    };
  }

  factory StudAttent.fromMap(Map<String, dynamic> map) {
    return StudAttent(
      session_id: map['session_id'] as String,
      class_id: map['class_id'] as String,
      stud_id: map['stud_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudAttent.fromJson(String source) => StudAttent.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AttenData {
  String date;
  String present;
  String absent;
  AttenData({
    required this.date,
    required this.present,
    required this.absent,
  });
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'present': present,
      'absent': absent,
    };
  }

  factory AttenData.fromMap(Map<String, dynamic> map) {
    return AttenData(
      date: map['date'] as String,
      present: map['present'] as String,
      absent: map['absent'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttenData.fromJson(String source) => AttenData.fromMap(json.decode(source) as Map<String, dynamic>);
}
