import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pbl_application/backend/models.dart';

void main() {

  // api.getTeacher(TeacherInfo(teach_email_id: 'soham@gmail.com', teach_password: 'passds123'));
  // api.getClasses('teach_836134');
  // api.createClass(ClassInfo(class_name: 'SE-11', class_subject: 'PBL', class_theme: "red",teach_id: 'teach_196201'));
}

class ApiRequests {
  // final String _url = "http://192.168.0.109:3000";
  // final String _url = "http://127.0.0.1:8000";
  final String _url = "http://192.168.223.162:3000";
  // final String _url = "http://172.28.96.1:3000";
  // final String _url = "https://fastapi-raw.onrender.com";

  Future<dynamic> getTeacher(TeacherInfo user) async {
    var resp = await http.post(Uri.parse("$_url/api/teacher/authorise"),
        body: user.toJson(),
        headers: <String, String>{"content-type": "application/json"});

    if (resp.statusCode == 200) {
      Teacher teacher = Teacher.fromJson(resp.body);
      return teacher;
    } else {
      return {'status': false, 'message': 'User Not Found'};
    }
  }

  Future<Map<String, Object>> registerTeacher(Teacher user) async {
    var resp = await http.post(Uri.parse("$_url/api/teacher/register"),
        body: user.toJson(),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.statusCode == 201) {
      return {'status': true, 'message': 'User Create'};
    } else if (resp.statusCode == 400) {
      return {'status': false, 'message': 'User Already Register'};
    }
    return {'status': false, 'message': 'Error while to creating the user'};
  }

  Future<void> createClass(ClassInfo classInfo) async {
    var resp = await http.post(Uri.parse("$_url/api/teacher/classes/create"),
        body: classInfo.toJson(),
        headers: <String, String>{"content-type": "application/json"});
  }

  Future<List<ClassModel>> getClasses(String teach_id) async {
    var resp = await http.get(
        Uri.parse('$_url/api/teacher/classes/$teach_id'),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.body.length > 2) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      List<ClassModel> myClassList = jsonList
          .map((jsonObject) => ClassModel(
              class_id: jsonObject['class_id'],
              class_name: jsonObject['class_name'],
              class_subject: jsonObject['class_subject'],
              class_created_date: jsonObject['class_created_date'],
              teach_id: jsonObject['teach_id'],
              class_no_of_student: jsonObject['class_no_of_student'],
              class_theme: jsonObject['class_theme']))
          .toList();
      return myClassList;
    }
    return [];
  }

  Future<dynamic> getStudent(StudentInfo user) async {
    var resp = await http.post(Uri.parse("$_url/api/student/authorise"),
        body: user.toJson(),
        headers: <String, String>{"content-type": "application/json"});

    if (resp.statusCode == 200) {
      Student student = Student.fromJson(resp.body);
      return student;
    } else {
      return {'status': false, 'message': 'User Not Found'};
    }
  }

  Future<Map<String, Object>> registerStudent(Student user) async {
    var resp = await http.post(Uri.parse("$_url/api/student/register"),
        body: user.toJson(),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.statusCode == 201) {
      return {'status': true, 'message': 'User Create'};
    } else if (resp.statusCode == 400) {
      return {'status': false, 'message': 'User Already Register'};
    }
    return {'status': false, 'message': 'Error while to creating the user'};
  }

  Future<Map<String, dynamic>> joinClass(
      String class_id, String stud_id) async {
    Map<String, dynamic> jsonData = {
      'class_id': class_id,
      'stud_id': stud_id,
    };
    var resp = await http.post(Uri.parse("$_url/api/student/classes/join"),
        body: jsonEncode(jsonData),
        headers: <String, String>{"content-type": "application/json"});
    Map<String, dynamic> jsonData1 = jsonDecode(resp.body);
    return jsonData1;
  }

  Future<List<Student>> getClassStudents(String class_id) async {
    var resp = await http.get(
        Uri.parse('$_url/api/teacher/classes/student/$class_id'),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.body.length > 2) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      List<Student> myClassList = jsonList
          .map((jsonObject) => Student(
              stud_email_id: jsonObject["stud_email_id"],
              stud_password: jsonObject["stud_attendance"],
              stud_id: jsonObject["stud_id"],
              stud_roll_no: jsonObject["stud_roll_no"],
              stud_name: jsonObject["stud_name"],
              stud_phone_no: jsonObject["stud_phone_no"],
              stud_institute_code: ' '))
          .toList();
      return myClassList;
    }
    return [];
  }

  Future<List<ClassModel>> getStudentClasses(String stud_id) async {
    var resp = await http.get(
        Uri.parse('$_url/api/student/classes/$stud_id'),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.body.length > 2) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      List<ClassModel> myClassList = jsonList
          .map((jsonObject) => ClassModel(
                class_id: jsonObject['class_id'],
                class_name: jsonObject['class_name'],
                class_subject: jsonObject['class_subject'],
                class_theme: jsonObject['class_theme'],
                teach_id: jsonObject['teach_id'],
                class_created_date: '',
                class_no_of_student: jsonObject['attendance'],
              ))
          .toList();
      return myClassList;
    }
    return [];
  }

  Future<ClassSession?> generateQrCode(String teachId, String classId) async {
    var resp = await http.get(
        Uri.parse("$_url/api/teacher/class/$teachId/session/$classId"),
        headers: <String, String>{"content-type": "application/json"});

    if (resp.statusCode == 200) {
      return ClassSession.fromJson(resp.body);
    } else {
      return null;
    }
  }

  Future<void> deactivateSession(String sessionId) async {
    var resp = await http.get(
        Uri.parse("$_url/api/teacher/class/session/$sessionId"),
        headers: <String, String>{"content-type": "application/json"});

    if (resp.statusCode == 200) {
    } else {}
  }

  Future<String> markAttendance(StudAttent attent) async {
    var resp = await http.post(
        Uri.parse("$_url/api/teacher/class/session/attendance"),
        body: attent.toJson(),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.statusCode == 200) {
      return 'Attendance Mark Successfully';
    } else if (resp.statusCode == 406) {
      return resp.body;
    } else {
      return 'Error while Marking Attendance';
    }
  }

  Future<List<AttenData>> getAttendanceData(String class_id) async {
    var resp = await http.get(
        Uri.parse('$_url/api/teacher/class/attendance/$class_id'),
        headers: <String, String>{"content-type": "application/json"});
    if (resp.body.length > 2) {
      List<dynamic> jsonList = jsonDecode(resp.body);
      List<AttenData> myClassList = jsonList
          .map((jsonObject) => AttenData(
              date: jsonObject['date'],
              present: jsonObject['present'],
              absent: jsonObject['absents']))
          .toList();
      return myClassList;
    }
    return [];
  }

  Future<AttenData> getAttendData(String class_id,String stud_id) async {
    var resp = await http.get(
        Uri.parse('$_url/api/student/classes/attent/${class_id}/${stud_id}'),
        headers: <String, String>{"content-type": "application/json"});

      Map<String, dynamic> jsonObject = jsonDecode(resp.body);
      AttenData myClassList = AttenData(
          date: jsonObject['total'],
          present: jsonObject['present'],
          absent: jsonObject['absent']);
      return myClassList;

  }
}
