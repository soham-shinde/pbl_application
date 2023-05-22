import 'package:flutter/material.dart';
import 'package:pbl_application/widgets/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/api_requests.dart';
import '../backend/models.dart';
import '../constants.dart';
import '../widgets/Custom_progress_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  var pageList = [
    const StudentHomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(child: CustomEndDrawer()),
      key: _scaffoldKey,
      body: SafeArea(child: pageList[_pageIndex]),
      bottomNavigationBar: Builder(builder: (context) {
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
                    setState(() {
                      _pageIndex = 0;
                    });
                  }),
              IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 28,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.primary,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScanner()),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class QRScanner extends StatefulWidget {

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey key = GlobalKey(debugLabel: 'qr');
  late QRViewController _controller;
  ApiRequests api = ApiRequests();

  String studId ='';

  bool loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((value) {
      setState(() {

      });
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      _controller.pauseCamera();
      print(scanData.code.toString());
      ClassSession session = ClassSession.fromJson(scanData.code.toString());
      print(session.session_id);
      CustomDialogs.showProgressDialog(context);
      api.markAttendance(StudAttent(session_id: session.session_id, class_id: session.class_id, stud_id: studId)).then((value){
        Navigator.pop(context);
        CustomDialogs.showUserCreateAlert(context, "msg", value, () => null);
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        CustomDialogs.showUserCreateAlert(context, "Error", "Error While Mark Attendance", () => null);
      });
    });
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    studId = prefs.getString(Constants.studId)!;
        loading = true;

    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: QRView(
                key: key,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.blue,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<ClassModel> _list = <ClassModel>[];
  ApiRequests api = ApiRequests();
  String studId = '';
  var loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    studId = prefs.getString(Constants.studId)!;
    api.getStudentClasses(studId).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? (_list.isNotEmpty)
            ? ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      AttenData? attendData;
                      bool show = false;
                      ApiRequests().getAttendData(_list[index].class_id, studId).then((value) {
                        attendData = value;
                        CustomDialogs().showDetailsClassDialog(context, _list[index],attendData!);
                        ;

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 7,
                        bottom: 10,
                        right: 15.0,
                      ),
                      child: StudentClassCard(
                        _list[index],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text("No Classes Found"))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
