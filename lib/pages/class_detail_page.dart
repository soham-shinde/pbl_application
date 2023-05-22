import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:qr_flutter/qr_flutter.dart';
import '../backend/api_requests.dart';
import '../widgets/Custom_progress_dialog.dart';

class ClassDetailsPage extends StatefulWidget {
  final ClassModel entity;
  const ClassDetailsPage({Key? key, required this.entity}) : super(key: key);

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState(entity);
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  int _pageIndex = 0;
  final ClassModel entity;
  _ClassDetailsPageState(this.entity);

  @override
  Widget build(BuildContext context) {
    var _pages = [
      ClassDetialsHomePage(entity: entity),
      StudentListPage(class_id: entity.class_id),
      QrCodePage(
        teachId: entity.teach_id,
        classId: entity.class_id,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: Builder(
        builder: (context) {
          return BottomAppBar(
            elevation: 8,
            color: Constants.primary,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.home,
                      size: 28,
                    ),
                    onPressed: () {
                      _pageIndex = 0;
                      setState(() {});
                    }),
                IconButton(
                  icon: SvgPicture.asset("assets/icons/tester-icon.svg"),
                  onPressed: () {
                    _pageIndex = 1;
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Constants.primary,
          child: const Icon(
            Icons.qr_code,
            color: Colors.black,
          ),
          onPressed: () {
            if (_pageIndex != 2) {
              setState(() {
                _pageIndex = 2;
              });
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ClassDetialsHomePage extends StatefulWidget {
  final ClassModel entity;

  ClassDetialsHomePage({Key? key, required this.entity}) : super(key: key);

  @override
  State<ClassDetialsHomePage> createState() => _ClassDetialsHomePageState();
}

class _ClassDetialsHomePageState extends State<ClassDetialsHomePage> {
  final List<BarChartModel> data = [
    BarChartModel(
      date: '08-03',
      attendance: 80,
      color: charts.ColorUtil.fromDartColor(Colors.cyan),
    ),
    BarChartModel(
      date: '09-03',
      attendance: 45,
      color: charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400),
    ),
    BarChartModel(
      date: '10-03',
      attendance: 55,
      color: charts.ColorUtil.fromDartColor(Colors.cyan),
    ),
    BarChartModel(
      date: '11-03',
      attendance: 65,
      color: charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400),
    ),
    BarChartModel(
      date: '12-04',
      attendance: 40,
      color: charts.ColorUtil.fromDartColor(Colors.cyan),
    ),
    BarChartModel(
      date: '13-03',
      attendance: 56,
      color: charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400),
    ),
    BarChartModel(
      date: '14-03',
      attendance: 23,
      color: charts.ColorUtil.fromDartColor(Colors.cyan),
    ),
    BarChartModel(
      date: '15-03',
      attendance: 50,
      color: charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400),
    ),
    BarChartModel(
      date: '16-03',
      attendance: 60,
      color: charts.ColorUtil.fromDartColor(Colors.cyan),
    ),
    BarChartModel(
      date: '17-03',
      attendance: 70,
      color: charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400),
    ),
  ];
  List<AttenData> _list = [];

  ApiRequests api = ApiRequests();

  Future<void> getData() async {
    api.getAttendanceData(widget.entity.class_id).then((value) {
      _list = value;
      setState(() {
        loading = true;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      setState(() {
        loading = true;
        CustomDialogs.showUserCreateAlert(
            context, "Error", 'Error While getting data', () {});
      });
    });
  }

  var loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AttenData, String>> series = [
      charts.Series(
          id: 'Attendance',
          data: _list.take(20).toList(),
          domainFn: (AttenData series, i) => '${series.date} $i',
          measureFn: (AttenData series, i) => int.parse(series.present),
          colorFn: (AttenData series, i) {
            if(i!%2==0){
              return  charts.ColorUtil.fromDartColor(Colors.cyanAccent.shade400);
            }else{
              return charts.ColorUtil.fromDartColor(Colors.cyan);
            }
          }),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              overlayColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey
                      .withOpacity(0.9); // Set the overlay color when pressed
                }
                return Colors.transparent; // Set the default overlay color
              }),
              child: Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.entity.class_theme),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.entity.class_name,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Subject : ${widget.entity.class_subject}',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "Class Id :  ${widget.entity.class_id}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Students :  ${widget.entity.class_no_of_student}",
                        style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.entity.class_id));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Class Id Copied on Clipboard'),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Container(
                height: 250,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child:  loading
                    ? (_list.isNotEmpty)
                    ?charts.BarChart(
                  series,
                  animate: true,
                  vertical: true,
                  animationDuration: const Duration(seconds: 1),
                  domainAxis: const charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelRotation: 45,
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 12,
                        color: charts.MaterialPalette.black,
                      ),
                    ),
                  ),
                ): const Center(
                  child: Text("No Classes Found"),
                )
                    : const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Past Attendance",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Date"),
                        Text("Present"),
                        Text("Absent"),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        height: 3,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: loading
                          ? (_list.isNotEmpty)
                              ? ListView.separated(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _list.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(_list[index].date),
                                        Text("P = ${_list[index].present}"),
                                        Text("A = ${_list[index].absent}"),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 20,
                                  ),
                                )
                              : const Center(
                                  child: Text("No Data Found"),
                                )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  String class_id;
  StudentListPage({Key? key, required this.class_id}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Student> _list = [];
  ApiRequests api = ApiRequests();
  bool listLength = false;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    api.getClassStudents(widget.class_id).then((value) {
      // print(value==null);
      _list = value;
      setState(() {
        if (_list.isNotEmpty) {
          listLength = true;
        }
        loading = true;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      setState(() {
        loading = true;
        CustomDialogs.showUserCreateAlert(
            context, "Error", 'Error While getting data', () {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? listLength
            ? ListView.separated(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      CustomDialogs().showDetailsDialog(context, _list[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 7,
                        bottom: 10,
                        right: 15.0,
                      ),
                      child: ListTile(
                        leading: Text(_list[index].stud_roll_no),
                        title: Text(_list[index].stud_name),
                        trailing: Text(_list[index].stud_password),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
              )
            : const Center(child: Text("No Student Enroll"))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class QrCodePage extends StatefulWidget {
  String classId;
  String teachId;

  QrCodePage({Key? key, required this.classId, required this.teachId})
      : super(key: key);

  @override
  State<QrCodePage> createState() {
    return _QrCodePageState();
  }
}

class _QrCodePageState extends State<QrCodePage> {
  ClassSession? session;
  bool loading = false;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    endSession();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateRandomCode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: session!.toJson(),
                  version: QrVersions.auto,
                  size: 350,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TimerCounter(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'End Session',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  void endSession() {
    ApiRequests().deactivateSession(session!.session_id).then((value) {});
  }

  void generateRandomCode() {
    ApiRequests().generateQrCode(widget.teachId, widget.classId).then((value) {
      session = value!;
      setState(() {
        loading = true;
      });
    });
  }
}

class TimerCounter extends StatefulWidget {
  const TimerCounter({Key? key}) : super(key: key);

  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  int counter = 100;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
        if (counter == 0) {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text("$counter");
  }
}
