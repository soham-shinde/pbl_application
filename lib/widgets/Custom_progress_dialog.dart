import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbl_application/backend/api_requests.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/constants.dart';
import 'package:pbl_application/pages/student_dashboard.dart';
import 'package:pbl_application/widgets/custom_widgets.dart';

class CustomDialogs {
  TextStyle textStyle = const TextStyle(fontSize: 16);
  static void showUserCreateAlert(BuildContext context,String msg,String? subMsg,Function() action){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: Text(subMsg!),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                action();
              },
            ),
          ],
        );
      },
    );

  }
   static void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 16.0),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDetailsDialog(BuildContext context, Student studentModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Roll No :',
                          style: textStyle,
                        ),
                        Text(
                          " ${studentModel.stud_roll_no} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Name :',
                          style: textStyle,
                        ),
                        Text(
                          " ${studentModel.stud_name} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Email:',
                          style: textStyle,
                        ),
                        Text(
                          " ${studentModel.stud_email_id} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Phone No :',
                          style: textStyle,
                        ),
                        Text(
                          " ${studentModel.stud_phone_no} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Attendance:'),
                        Text(studentModel.stud_password),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
  void showDetailsClassDialog(BuildContext context, ClassModel classModel,AttenData attenData) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Information',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Class Name',
                          style: textStyle,
                        ),
                        Text(
                          " ${classModel.class_name} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Session :',
                          style: textStyle,
                        ),
                        Text(
                          " ${attenData.date } ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Attended:',
                          style: textStyle,
                        ),
                        Text(
                          " ${attenData.present } ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Absent :',
                          style: textStyle,
                        ),
                        Text(
                          " ${attenData.absent} ",
                          style: textStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Attendance:'),
                        Text(classModel.class_no_of_student),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
  void showJoinClassDialog(BuildContext context,String stud_id) {
    TextEditingController classId = TextEditingController();
    final _fromKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Join New Class",style: TextStyle(fontSize: 16),),
                    SizedBox(height: 20,),
                    Form(key: _fromKey,
                      child: CustomTextField(labelText: "Class Id", keyboardType: TextInputType.text, controller: classId, passwordField: false, isNumber: false,validator: (data) {
                    if (data == null || data.isEmpty) {
                    return 'Please enter class id';
                    }

                    return null;
                    },),),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(onPressed: (){
                        if(_fromKey.currentState!.validate()){
                          ApiRequests().joinClass(classId.text.toString(),stud_id).then((value) {
                            CustomDialogs.showUserCreateAlert(context, "Successful", '${classId.text.toString()} ${value['detail']}', () {
                              Navigator.pushReplacement(context,PageTransitionAnimation(page: const StudentDashboard()));
                            });
                          }).onError((error, stackTrace) {
                            print(error);
                            print(stackTrace);
                            CustomDialogs.showUserCreateAlert(context, 'Error', 'error while join class $error', () => null);
                          });
                        }
                      },style: ElevatedButton.styleFrom(backgroundColor: Constants.primary), child: const Text('Join Class'),),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
