import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pbl_application/backend/api_requests.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/constants.dart';
import 'package:pbl_application/pages/dashboard_page.dart';
import 'package:pbl_application/pages/registration_page.dart';
import 'package:pbl_application/pages/student_dashboard.dart';
import 'package:pbl_application/widgets/Custom_progress_dialog.dart';
import 'package:pbl_application/widgets/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  CustomDialogs progressDialog = CustomDialogs();
  String user = '';
  ApiRequests api = ApiRequests();
  String? selectedValue;

  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/images/background_circle.svg',
                  alignment: Alignment.topLeft,
                  width: 200,
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Container(
                height: 150,
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/images/login.svg'),
              ),
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                        isNumber: false,
                        passwordField: false,
                        labelText: "Email id ",
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'Please enter email id';
                          }
                          if (!Constants.emailValidatorRegExp.hasMatch(data)) {
                            return 'Enter Valid Email id';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                        isNumber: false,
                        passwordField: true,
                        labelText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomDropdownFormField(
                          value: selectedValue,
                          errorText: "please select user type",
                          onChanged: (value) {
                            user = value!;
                          },
                          hint: "Select User Type",
                        )),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style:
                    TextButton.styleFrom(foregroundColor: Colors.transparent),
                child: Text(
                  "Forget Password",
                  style: TextStyle(color: Constants.deepJungleGreen),
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
                      if (user == Constants.teacher) {
                        api.getTeacher(
                          TeacherInfo(
                              teach_email_id: email.text.toString(),
                              teach_password: password.text.toString()),
                        )
                            .then((value) async {
                          Navigator.of(context).pop();
                          if (value.runtimeType == Teacher) {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('teach_id', value.teach_id);
                            await prefs.setString(Constants.user, user);
                            await prefs.setString(
                                Constants.teachName, value.teach_name);
                            await prefs.setBool(Constants.loginStatus, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            );
                          } else {
                            CustomDialogs.showUserCreateAlert(context, 'Error',
                                'User not Found'.toString(), () => null);
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                          print(stackTrace);
                          Navigator.of(context).pop();
                          CustomDialogs.showUserCreateAlert(
                              context,
                              'Error',
                              'Error while Getting Information'.toString(),
                              () => null);
                        });
                      } else if (user == Constants.student) {
                        api
                            .getStudent(StudentInfo(
                                stud_email_id: email.text.toString(),
                                stud_password: password.text.toString()))
                            .then((value) async {
                          Navigator.of(context).pop();
                          if (value.runtimeType == Student) {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                Constants.studId, value.stud_id);
                            await prefs.setString(Constants.user, user);
                            await prefs.setString(
                                Constants.studName, value.stud_name);
                            await prefs.setBool(Constants.loginStatus, true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentDashboard(),
                              ),
                            );
                          } else {
                            CustomDialogs.showUserCreateAlert(context, 'Error',
                                'User not Found'.toString(), () => null);
                          }
                        }).onError((error, stackTrace) {
                          Navigator.of(context).pop();
                          print(error);
                          print(stackTrace);
                          CustomDialogs.showUserCreateAlert(context, 'Error',
                              'Error while Getting Information ', () => null);
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Constants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const RegisterPage(),
                      transitionsBuilder: (_, anim, __, child) {
                        return SlideTransition(
                          position: Tween(
                            begin: const Offset(1.0, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(anim),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  'Don’t have an account?  Sign up',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
