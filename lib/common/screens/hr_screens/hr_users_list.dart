import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_users.dart';
import 'package:timesheet/common/screens/hr_screens/hr_myteam.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_users.dart';
import 'package:timesheet/common/screens/superadmin_screens/verify_users_screen.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_users_card.dart';

class UsersHRScreen extends StatefulWidget {
  const UsersHRScreen({super.key, required this.title});

  final String title;

  @override
  State<UsersHRScreen> createState() => _UsersHRScreenState();
}

class _UsersHRScreenState extends State<UsersHRScreen> {
  final HRUsersController hrUc = HRUsersController();

  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;
  final double height = 160;
  final double width = 400;

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    hrUc;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await hrUc.getHRUsersList().then((value) {
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
                      AppController.setVerification(0);
                      Get.to(const MyTeamScreen(title: 'My Team List'));
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
                              'My Team',
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
                  // const SizedBox(width: 10),
                  Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(milliseconds: 20),
                    color: Colors.white,
                    colorOpacity: 1,
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(HRCreateUsers(title: 'Create Users'));
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
                                'Create Users',
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
                                            String firstName =
                                                dataList![index].firstName;
                                            String lastName =
                                                dataList![index].lastName;
                                            String email =
                                                dataList![index].email;
                                            String mobileNo =
                                                dataList![index].mobileNo;
                                            int isManager =
                                                dataList![index].isManager;
                                            int id = dataList![index].id;
                                            int reportingManagerId =
                                                dataList![index]
                                                    .reportingManager;
                                            String reportingManagerWithName =
                                                dataList![index]
                                                    .reportingManagerWithName;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateUserScreen(
                                                title: 'Update User',
                                                id: id,
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                mobileNo: mobileNo,
                                                isManager: isManager.toString(),
                                                reportingManagerId:
                                                    reportingManagerId,
                                                reportingManagerWithName:
                                                    reportingManagerWithName,
                                              ));
                                            }
                                          },
                                          child: HRUsersCard(
                                            ht: height,
                                            wd: width,
                                            duration: 200,
                                            name:
                                                ' ${dataList![index].firstName} ${dataList![index].lastName}',
                                            email: dataList![index].email,
                                            mobile: dataList![index].mobileNo,
                                            reportingManager: dataList![index]
                                                .reportingManagerWithName,
                                            isManager:
                                                dataList![index].isManager == 0
                                                    ? 'no'
                                                    : 'yes',
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
                                            String firstName =
                                                dataList![index].firstName;
                                            String lastName =
                                                dataList![index].lastName;
                                            String email =
                                                dataList![index].email;
                                            String mobileNo =
                                                dataList![index].mobileNo;
                                            int isManager =
                                                dataList![index].isManager;
                                            int id = dataList![index].id;
                                            int reportingManagerId =
                                                dataList![index]
                                                    .reportingManager;
                                            String reportingManagerWithName =
                                                dataList![index]
                                                    .reportingManagerWithName;

                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateUserScreen(
                                                title: 'Update User',
                                                id: id,
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                mobileNo: mobileNo,
                                                isManager: isManager.toString(),
                                                reportingManagerId:
                                                    reportingManagerId,
                                                reportingManagerWithName:
                                                    reportingManagerWithName,
                                              ));
                                            }
                                          },
                                          child: HRUsersCard(
                                            ht: height,
                                            wd: width,
                                            duration: 200,
                                            name:
                                                ' ${dataList![index].firstName} ${dataList![index].lastName}',
                                            email: dataList![index].email,
                                            mobile: dataList![index].mobileNo,
                                            reportingManager: dataList![index]
                                                .reportingManagerWithName,
                                            isManager:
                                                dataList![index].isManager == 0
                                                    ? 'no'
                                                    : 'yes',
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
                                            String firstName =
                                                dataList![index].firstName;
                                            String lastName =
                                                dataList![index].lastName;
                                            String email =
                                                dataList![index].email;
                                            String mobileNo =
                                                dataList![index].mobileNo;
                                            int isManager =
                                                dataList![index].isManager;
                                            int id = dataList![index].id;
                                            int reportingManagerId =
                                                dataList![index]
                                                    .reportingManager;
                                            String reportingManagerWithName =
                                                dataList![index]
                                                    .reportingManagerWithName;
                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateUserScreen(
                                                title: 'Update User',
                                                id: id,
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                mobileNo: mobileNo,
                                                isManager: isManager.toString(),
                                                reportingManagerId:
                                                    reportingManagerId,
                                                reportingManagerWithName:
                                                    reportingManagerWithName,
                                              ));
                                            }
                                          },
                                          child: HRUsersCard(
                                            ht: 210,
                                            wd: width,
                                            duration: 200,
                                            name:
                                                ' ${dataList![index].firstName} ${dataList![index].lastName}',
                                            email: dataList![index].email,
                                            mobile: dataList![index].mobileNo,
                                            reportingManager: dataList![index]
                                                .reportingManagerWithName,
                                            isManager:
                                                dataList![index].isManager == 0
                                                    ? 'no'
                                                    : 'yes',
                                            rejectReason:
                                                dataList![index].rejectReason,
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
                                            String firstName =
                                                dataList![index].firstName;
                                            String lastName =
                                                dataList![index].lastName;
                                            String email =
                                                dataList![index].email;
                                            String mobileNo =
                                                dataList![index].mobileNo;
                                            int isManager =
                                                dataList![index].isManager;
                                            int id = dataList![index].id;
                                            int reportingManagerId =
                                                dataList![index]
                                                    .reportingManager;
                                            String reportingManagerWithName =
                                                dataList![index]
                                                    .reportingManagerWithName;

                                            if (AppController.role ==
                                                'hrManager') {
                                              Get.to(HRUpdateUserScreen(
                                                title: 'Update User',
                                                id: id,
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                mobileNo: mobileNo,
                                                isManager: isManager.toString(),
                                                reportingManagerId:
                                                    reportingManagerId,
                                                reportingManagerWithName:
                                                    reportingManagerWithName,
                                              ));
                                            } else if (AppController.role ==
                                                'superAdmin') {
                                              Get.to(VerifyUsersScreen(
                                                title: 'Verify User',
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                mobileNo: mobileNo,
                                                reportingManager:
                                                    reportingManagerWithName,
                                                isManager: isManager,
                                                userId: id,
                                              ));
                                            }
                                          },
                                          child: HRUsersCard(
                                            ht: height,
                                            wd: width,
                                            duration: 200,
                                            name:
                                                ' ${dataList![index].firstName} ${dataList![index].lastName}',
                                            email: dataList![index].email,
                                            mobile: dataList![index].mobileNo,
                                            reportingManager: dataList![index]
                                                .reportingManagerWithName,
                                            isManager:
                                                dataList![index].isManager == 0
                                                    ? 'no'
                                                    : 'yes',
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
