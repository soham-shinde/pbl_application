import 'package:flutter/material.dart';
import 'package:pbl_application/backend/api_requests.dart';
import 'package:pbl_application/backend/models.dart';
import 'package:pbl_application/constants.dart';
import 'package:pbl_application/pages/class_detail_page.dart';
import 'package:pbl_application/widgets/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/Custom_progress_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageIndex = 0;
  var pageList = [
    const DashboardHomePage(),
  ];
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true, // set to true to enable scrolling
        context: context,
        builder: (BuildContext context) {
          return const CustomBottomSheet();
        });
  }

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
            _showBottomSheet(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DashboardHomePage extends StatefulWidget {
  const DashboardHomePage({Key? key}) : super(key: key);

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  List<ClassModel> _list = <ClassModel>[];
  ApiRequests api = ApiRequests();
  String teach_id = '';
  var loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    teach_id = prefs.getString('teach_id')!;
    print('$teach_id abc');
    api.getClasses(teach_id).then((value) {
      // print(value==null);
      print(value);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassDetailsPage(
                            entity: _list[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 7,
                        bottom: 10,
                        right: 15.0,
                      ),
                      child: ClassCard(
                        _list[index],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("No Classes Found"),
              )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
