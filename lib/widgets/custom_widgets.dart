import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pbl_application/backend/api_requests.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/constants.dart';
import 'package:pbl_application/pages/dashboard_page.dart';
import 'package:pbl_application/pages/login_page.dart';
import 'package:pbl_application/pages/student_dashboard.dart';
import 'package:pbl_application/widgets/Custom_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  int? maxLength;
  bool passwordField = false;
  bool isNumber = false;
  String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    required this.passwordField,
    this.maxLength,
    this.validator,
    required this.isNumber,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final myFocusNode = FocusNode();
  bool isFocused = false;
  bool _secureText = true;

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(
      () {
        setState(
          () {
            isFocused = myFocusNode.hasFocus;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      focusNode: myFocusNode,
      inputFormatters:
          widget.isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      cursorColor: isFocused ? Constants.primary : Colors.grey,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        suffixIcon: widget.passwordField
            ? IconButton(
                icon: _secureText
                    ? SvgPicture.asset(
                        "assets/icons/hide-private-hidden-icon.svg",
                        color: isFocused ? Constants.primary : Colors.grey,
                      )
                    : SvgPicture.asset(
                        "assets/icons/view-icon.svg",
                        color: isFocused ? Constants.primary : Colors.grey,
                      ),
                onPressed: () {
                  setState(
                    () {
                      _secureText = !_secureText;
                    },
                  );
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: isFocused ? Constants.primary : Colors.grey,
          fontStyle: FontStyle.normal,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.primary,
          ),
        ),
      ),
      obscureText: widget.passwordField ? _secureText : false,
      keyboardType: widget.keyboardType,
    );
  }
}

class ClassCard extends StatefulWidget {
  ClassModel entity;
  ClassCard(this.entity, {super.key});

  @override
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage(
            widget.entity.class_theme,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entity.class_name,
              style: const TextStyle(
                fontSize: 40,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.entity.class_subject,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              "Students : ${widget.entity.class_no_of_student}",
              style: const TextStyle(
                fontSize: 23,
                fontFamily: 'Lato',
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentClassCard extends StatefulWidget {
  ClassModel entity;
  StudentClassCard(this.entity,{Key? key}) : super(key: key);

  @override
  State<StudentClassCard> createState() => _StudentClassCardState();
}

class _StudentClassCardState extends State<StudentClassCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage(
            widget.entity.class_theme,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entity.class_name,
              style: const TextStyle(
                fontSize: 40,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.entity.class_subject,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              "Attendance : ${widget.entity.class_no_of_student}",
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Lato',
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DropdownButtonExample extends StatefulWidget {
  String? Function(String?)? onChange;

  DropdownButtonExample({super.key, this.onChange});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  var items = [
    ['Green', 'assets/images/asset_bg_green.png'],
    ['Pale Blue', 'assets/images/asset_bg_paleblue.png'],
    ['Pale Green', 'assets/images/asset_bg_palegreen.png'],
    ['Pale Orange', 'assets/images/asset_bg_paleorange.png'],
    ['White', 'assets/images/asset_bg_white.png'],
    ['Yellow', 'assets/images/asset_bg_yellow.png'],
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item[1],
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            item[1],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      item[0],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          widget.onChange!(value);
          setState(
            () {
              selectedValue = value;
            },
          );
        },
        buttonStyleData: ButtonStyleData(
          height: 60,
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            color: Colors.white,
          ),
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          elevation: 8,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  TextEditingController className = TextEditingController();
  TextEditingController classSubject = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  String? classTheme;
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Please enter Class name';
                        }
                        return null;
                      },
                      labelText: "Class Name",
                      keyboardType: TextInputType.text,
                      controller: className,
                      passwordField: false,
                      isNumber: false,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      isNumber: false,
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Please enter Class Subject';
                        }
                        return null;
                      },
                      labelText: "Class Subject",
                      keyboardType: TextInputType.text,
                      controller: classSubject,
                      passwordField: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonExample(
                onChange: (theme) {
                  classTheme = theme;
                  setState(
                    () {
                      showError = false;
                    },
                  );
                  return null;
                },
              ),
              if (showError) // conditionally show error message
                const Text(
                  'Please select an option',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Constants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Create'),
                  onPressed: () async {
                    if (classTheme == null) {
                      setState(() {
                        showError = true;
                      });
                    }
                    if (_fromKey.currentState!.validate() &&
                        classTheme != null) {
                      ApiRequests api = ApiRequests();
                      CustomDialogs.showProgressDialog(context);
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final String? teachId = prefs.getString('teach_id');
                      api
                          .createClass(ClassInfo(
                              class_name: className.text.toString(),
                              class_subject: classSubject.text.toString(),
                              class_theme: '$classTheme',
                              teach_id: '$teachId'))
                          .then((value) {
                        Navigator.pop(context);
                        CustomDialogs.showUserCreateAlert(
                          context,
                          "Class Created",
                          'New Class Create Successfully',
                          () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const DashboardPage();
                                },
                              ),
                            );
                          },
                        );
                      }).onError((error, stackTrace) {
                        Navigator.pop(context);
                        CustomDialogs.showUserCreateAlert(
                            context, "Error", 'Error While Creating the Class',
                            () {
                          Navigator.pop(context);
                        });
                      });
                    } else {}
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomAppBar extends StatefulWidget {
  Widget? child;
  CustomBottomAppBar({Key? key, this.child}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      color: Constants.primary,
      height: 60,
      child: widget.child,
    );
  }
}

class CustomEndDrawer extends StatefulWidget {
  CustomEndDrawer({Key? key}) : super(key: key);

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  String name = '';
  String user = '';
  String id = '';

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString(Constants.user)!;
    if(user==Constants.teacher){
      name = prefs.getString(Constants.teachName)!;
    }else if(user == Constants.student){
      name = prefs.getString(Constants.studName)!;
      id = prefs.getString(Constants.studId)!;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              color: Constants.primary,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Reload'),
            onTap: () {
              if(user == Constants.teacher){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const DashboardPage()));
              }
              else if (user == Constants.student){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const StudentDashboard()));
              }
            },
          ),
          (user == Constants.student)?ListTile(
            leading: SvgPicture.asset(width: 16,
                height: 16,"assets/icons/training-online-icon.svg",color: Colors.grey,),
            title: const Text('Join Class'),
            onTap: () async {
              CustomDialogs().showJoinClassDialog(context,id);
            },
          ):const SizedBox(),
          ListTile(
            leading: const Icon(Icons.login_sharp),
            title: const Text('Logout'),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool(Constants.loginStatus, false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (builder) => const LoginPage(),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

class CustomDropdownFormField extends StatefulWidget {
  final String? value;
  List<DropdownMenuItem<String>> get items{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: Constants.teacher, child: Text("Teacher")),
      const DropdownMenuItem(value: Constants.student, child: Text("Student")),

    ];

    return menuItems;
  }
  final String? hint;
  final String? errorText;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownFormField({
    Key? key,
    required this.value,
    this.hint,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdownFormField> createState() => _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {

  final myFocusNode = FocusNode();
  bool isFocused = false;
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(
          () {
        setState(
              () {
            isFocused = myFocusNode.hasFocus;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: myFocusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: isFocused ? Constants.primary : Colors.grey, width: 2),
        ),
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.hint,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey , width: 2)),
      ),
      value: widget.value,
      onChanged: widget.onChanged,
      items: widget.items,
      validator:  (value) => value == null ? widget.errorText : null,
    );
  }
}

class PageTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  PageTransitionAnimation({required this.page})
      : super(
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return page;
    },
  );
}