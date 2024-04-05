import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/getall_verified_departemnets.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_department.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_department.dart';
import 'package:timesheet/common/screens/hr_screens/my_departments.dart';
import 'package:timesheet/common/screens/superadmin_screens/verify_department_screen.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_department_card.dart';

class DepartmentsHRScreen extends StatefulWidget {
  const DepartmentsHRScreen({super.key, required this.title});

  final String title;

  @override
  State<DepartmentsHRScreen> createState() => _DepartmentsHRScreenState();
}

class _DepartmentsHRScreenState extends State<DepartmentsHRScreen> {
  final HRUsersController hrUc = HRUsersController();

  final AllDepartmentList allDept = AllDepartmentList();

  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    allDept;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await allDept.getAllDepartments().then((value) {
        setState(() {
          dataList = value;
          mainDataList = value;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      // automaticallyImplyLeading: false,
      // shadowColor: Colors.black87,
      // elevation: 1,
      body: Column(children: [
        const SizedBox(height: 40),
        GlassContainer(
          height: 50,
          width: double.infinity,
          blur: 10,
          color: Colors.white.withOpacity(0.1),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.8),
              const Color.fromARGB(255, 242, 236, 236).withOpacity(0.9),
            ],
          ),
          //--code to remove border
          border: const Border.fromBorderSide(BorderSide.none),
          shadowStrength: 10,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.white.withOpacity(0.24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Shimmer(
                  duration: const Duration(seconds: 2),
                  interval: const Duration(milliseconds: 20),
                  color: Colors.white,
                  colorOpacity: 1,
                  enabled: true,
                  direction: const ShimmerDirection.fromLTRB(),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(MyDepartmentsScreen(title: 'My Departments list'));
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(6)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'My Departments',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (AppController.role == 'hrManager')
                  Shimmer(
                    duration: const Duration(seconds: 2),
                    // This is NOT the default value. Default value: Duration(seconds: 0)
                    interval: const Duration(milliseconds: 20),
                    // This is the default value
                    color: Colors.white,
                    // This is the default value
                    colorOpacity: 1,
                    // This is the default value
                    enabled: true,
                    // This is the default value
                    direction: const ShimmerDirection.fromLTRB(),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const HRCreateDepartments(
                            title: 'Create Departments'));
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Create Department',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),

        //

        const SizedBox(height: 10),
        Expanded(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  onTap: (index) {
                    if (index == 0) {
                      setState(() {
                        dataList = mainDataList;
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    } else if (index == 1) {
                      setState(() {
                        dataList = mainDataList
                            ?.where((element) => element.isVerified == 1)
                            .toList();
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    } else if (index == 2) {
                      setState(() {
                        dataList = mainDataList
                            ?.where((element) => element.isVerified == 2)
                            .toList();
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    } else if (index == 3) {
                      setState(() {
                        dataList = mainDataList
                            ?.where((element) => element.isVerified == 0)
                            .toList();
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    }
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  unselectedBackgroundColor: Colors.white70,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(243, 84, 86, 80),
                        Color.fromARGB(255, 151, 223, 126),
                      ],
                    ),
                  ),
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.all_inbox),
                      text: "All",
                    ),
                    Tab(
                      icon: Icon(Icons.approval),
                      text: "Verified",
                    ),
                    Tab(
                      icon: Icon(Icons.wrong_location_rounded),
                      text: "Unverified",
                    ),
                    Tab(
                      icon: Icon(Icons.pending),
                      text: "Pending",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child: Builder(builder: (
                                BuildContext context,
                              ) {
                                if (dataList == null || dataList!.isEmpty) {
                                  return const Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   'assets/loaderr.gif',
                                      //   height: 200,
                                      //   width: 130,
                                      // ),
                                      Text('No records found')
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            int deptId = dataList![index].id;
                                            String deptName =
                                                dataList![index].name;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateDepartment(
                                                deptName: deptName,
                                                title: 'Update Department',
                                                deptId: deptId,
                                              ));
                                            }
                                          },
                                          child: HRDepartmentCard(
                                            ht: 110,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            remark: dataList![index]
                                                .remark
                                                .toString(),
                                          ),
                                        );
                                      });
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child: Builder(builder: (
                                BuildContext context,
                              ) {
                                if (dataList == null || dataList!.isEmpty) {
                                  return const Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   'assets/loaderr.gif',
                                      //   height: 200,
                                      //   width: 130,
                                      // ),
                                      Text('No records found')
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            int deptId = dataList![index].id;
                                            String deptName =
                                                dataList![index].name;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateDepartment(
                                                deptName: deptName,
                                                title: 'Update Department',
                                                deptId: deptId,
                                              ));
                                            }
                                          },
                                          child: HRDepartmentCard(
                                            ht: 110,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            remark: dataList![index]
                                                .remark
                                                .toString(),
                                          ),
                                        );
                                      });
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Expanded(
                              child: Builder(builder: (
                                BuildContext context,
                              ) {
                                if (dataList == null || dataList!.isEmpty) {
                                  return const Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   'assets/loaderr.gif',
                                      //   height: 200,
                                      //   width: 130,
                                      // ),
                                      Text('No records found')
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            int deptId = dataList![index].id;
                                            String deptName =
                                                dataList![index].name;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateDepartment(
                                                deptName: deptName,
                                                title: 'Update Department',
                                                deptId: deptId,
                                              ));
                                            }
                                          },
                                          child: HRDepartmentCard(
                                            ht: 110,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            remark: dataList![index]
                                                .remark
                                                .toString(),
                                          ),
                                        );
                                      });
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child: Builder(builder: (
                                BuildContext context,
                              ) {
                                if (dataList == null || dataList!.isEmpty) {
                                  return const Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image.asset(
                                      //   'assets/loaderr.gif',
                                      //   height: 200,
                                      //   width: 130,
                                      // ),
                                      Text('No records found')
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            int deptId = dataList![index].id;
                                            String deptName =
                                                dataList![index].name;
                                            String createdAt =
                                                dataList![index].createdAt;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateDepartment(
                                                deptName: deptName,
                                                title: 'Update Department',
                                                deptId: deptId,
                                              ));
                                            } else if (AppController.role ==
                                                'superAdmin') {
                                              Get.to(VerifyDepartmentScreen(
                                                  title: 'VerifyDepartment',
                                                  deptName: deptName,
                                                  deptId: deptId,
                                                  createdAt: createdAt));
                                            }
                                          },
                                          child: HRDepartmentCard(
                                            ht: 110,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            remark: dataList![index]
                                                .remark
                                                .toString(),
                                          ),
                                        );
                                      });
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //
      ]),
    );
  }
}
