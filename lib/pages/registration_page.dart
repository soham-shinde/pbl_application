import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pbl_application/backend/api_requests.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/pages/login_page.dart';
import 'package:pbl_application/widgets/Custom_progress_dialog.dart';
import 'package:pbl_application/widgets/custom_widgets.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController rollNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController instituteCode = TextEditingController();
  TextEditingController password = TextEditingController();
  String? selectedUser;
  bool visibleRollno = false;

  ApiRequests api = ApiRequests();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Constants.background,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    "assets/images/background_circle.svg",
                    alignment: Alignment.topLeft,
                    width: 150,
                  ),
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Let’s help you meet up your tasks.. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomDropdownFormField(
                          value: null,
                          errorText: "please select user type",
                          onChanged: (value) {
                            selectedUser = value;
                            if (value == 'student') {
                              setState(() {
                                visibleRollno = true;
                              });
                            } else {
                              setState(() {
                                visibleRollno = false;
                              });
                            }
                          },
                          hint: "Select User Type",
                        ),
                      ),
                      visibleRollno
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: CustomTextField(
                                  isNumber: false,
                                  labelText: 'Roll No',
                                  passwordField: false,
                                  keyboardType: TextInputType.text,
                                  controller: rollNo,
                                  validator: (date) {
                                    if (date == null || date.isEmpty) {
                                      return 'Please enter your Roll No';
                                    }
                                    return null;
                                  }),
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomTextField(
                            isNumber: false,
                            labelText: 'Name',
                            passwordField: false,
                            keyboardType: TextInputType.text,
                            controller: name,
                            validator: (date) {
                              if (date == null || date.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomTextField(
                            isNumber: false,
                            controller: email,
                            keyboardType: TextInputType.text,
                            labelText: 'Email',
                            passwordField: false,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please enter email id';
                              }
                              if (!Constants.emailValidatorRegExp
                                  .hasMatch(data)) {
                                return 'Please enter valid email id';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomTextField(
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter Phone no.';
                            }
                            if (data.length < 10) {
                              return 'Please enter 10 digit no.';
                            }
                            return null;
                          },
                          isNumber: true,
                          controller: phone,
                          keyboardType: TextInputType.number,
                          labelText: 'Phone',
                          maxLength: 10,
                          passwordField: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomTextField(
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter Institute Code/Name';
                            }
                            return null;
                          },
                          isNumber: false,
                          controller: instituteCode,
                          keyboardType: TextInputType.text,
                          labelText: 'Institute Code / Name',
                          passwordField: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 15),
                        child: CustomTextField(
                          validator: (data) {
                            if (data == null || data.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          isNumber: false,
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          passwordField: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        CustomDialogs.showProgressDialog(context);
                        if (!visibleRollno) {
                          api
                              .registerTeacher(Teacher(
                                  teach_id: 'teach_id',
                                  teach_name: name.text.toString().trim(),
                                  teach_phone_no: phone.text.toString().trim(),
                                  teach_institution_code:
                                      instituteCode.text.toString().trim(),
                                  teach_email_id: email.text.toString().toLowerCase().trim(),
                                  teach_password: password.text.toString().trim(),),)
                              .then((value) {
                            print(value);
                            Navigator.of(context).pop();
                            if (value['status'] == true) {
                              CustomDialogs.showUserCreateAlert(
                                context,
                                'User Created',
                                "User Successfully Created",
                                () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const LoginPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: Tween<double>(
                                                  begin: 0.0, end: 1.0)
                                              .animate(animation),
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                    ),
                                  );
                                },
                              );
                            } else {
                              CustomDialogs.showUserCreateAlert(
                                  context,
                                  'Error',
                                  value['message'].toString(),
                                  () => null);
                            }
                          });
                        } else {
                          api.registerStudent(Student(
                              stud_email_id: email.text.toString().toLowerCase().trim(),
                              stud_password: password.text.trim(),
                              stud_id: "stud_id",
                              stud_roll_no: rollNo.text.trim(),
                              stud_name: name.text.trim(),
                              stud_phone_no: phone.text.trim(),
                              stud_institute_code: instituteCode.text.trim(),),).then((value){
                            print(value);
                            Navigator.of(context).pop();
                            if (value['status'] == true) {
                              CustomDialogs.showUserCreateAlert(
                                context,
                                'User Created',
                                "User Successfully Created",
                                    () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const LoginPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: Tween<double>(
                                              begin: 0.0, end: 1.0)
                                              .animate(animation),
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                      const Duration(milliseconds: 200),
                                    ),
                                  );
                                },
                              );
                            } else {
                              CustomDialogs.showUserCreateAlert(
                                  context,
                                  'Error',
                                  value['message'].toString(),
                                      () => null);
                            }
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: Tween<double>(begin: 0.0, end: 1.0)
                                .animate(animation),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                      ),
                    );
                  },
                  child: const Text(
                    'Already have Account ? login',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
