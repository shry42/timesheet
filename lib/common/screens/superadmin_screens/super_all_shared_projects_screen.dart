import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/project_share_controllers/get_all_shared_projects_controller.dart';
import 'package:timesheet/common/screens/superadmin_screens/verify_all_shared_project_screen.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_projects_card.dart';
import 'package:timesheet/utils/widgets/share_project_dilaog.dart';

class AllSharedProjectsScreenSuper extends StatefulWidget {
  const AllSharedProjectsScreenSuper({super.key, required this.title});

  final String title;

  @override
  State<AllSharedProjectsScreenSuper> createState() =>
      _AllSharedProjectsScreenSuperState();
}

class _AllSharedProjectsScreenSuperState
    extends State<AllSharedProjectsScreenSuper> {
  final AllSharedProjectsController aspc = AllSharedProjectsController();

  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await aspc.getAllSharedProjects().then((value) {
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
                if (AppController.role == 'hrManager')
                  Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(milliseconds: 20),
                    color: Colors.white,
                    colorOpacity: 1,
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 215, 196),
                          title: 'Share Project',
                          content: const ShareProjectDialogScreen(),
                        );
                        // Get.to(ShareProjectDialogScreen());
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
                                'Share Project',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
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
                            ?.where(
                                (element) => element.sharedProjectStatus == 1)
                            .toList();
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    } else if (index == 2) {
                      setState(() {
                        dataList = mainDataList
                            ?.where(
                                (element) => element.sharedProjectStatus == 2)
                            .toList();
                        searchDataList = dataList;
                        // searchController.clear();
                      });
                    } else if (index == 3) {
                      setState(() {
                        dataList = mainDataList
                            ?.where(
                                (element) => element.sharedProjectStatus == 0)
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
                                      Text('No records found'),
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: HRProjectsCard(
                                            ht: 260,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            code: dataList![index]
                                                .code
                                                .toString(),
                                            startDate: dataList![index]
                                                .startDate
                                                .toString(),
                                            endDate: dataList![index]
                                                .endDate
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            deptName: dataList![index].deptName,
                                            sharedTo:
                                                dataList![index].sharedToName,
                                            sharedBy:
                                                dataList![index].projectOwner,
                                            sharedProjectStatus: dataList![
                                                            index]
                                                        .sharedProjectStatus ==
                                                    0
                                                ? 'In Progress'
                                                : dataList![index]
                                                            .sharedProjectStatus ==
                                                        1
                                                    ? 'Verified'
                                                    : dataList![index]
                                                                .sharedProjectStatus ==
                                                            2
                                                        ? 'Rejected'
                                                        : 'Unknown',
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
                                      Text('No records found'),
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: HRProjectsCard(
                                            ht: 250,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            code: dataList![index]
                                                .code
                                                .toString(),
                                            startDate: dataList![index]
                                                .startDate
                                                .toString(),
                                            endDate: dataList![index]
                                                .endDate
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            deptName: dataList![index].deptName,
                                            sharedTo:
                                                dataList![index].sharedToName,
                                            sharedBy:
                                                dataList![index].projectOwner,
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
                                      Text('No records found'),
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: HRProjectsCard(
                                            ht: 290,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            code: dataList![index]
                                                .code
                                                .toString(),
                                            startDate: dataList![index]
                                                .startDate
                                                .toString(),
                                            endDate: dataList![index]
                                                .endDate
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            deptName: dataList![index].deptName,
                                            sharedTo:
                                                dataList![index].sharedToName,
                                            sharedBy:
                                                dataList![index].projectOwner,
                                            remark: dataList![index]
                                                .sharedProjectReason,
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
                                      Text('No records found'),
                                    ],
                                  ));
                                } else {
                                  return ListView.builder(
                                      itemCount: dataList!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            Get.to(VerifyAllSharedProjectScreen(
                                              title: 'Verify Shared Project',
                                              name: dataList![index]
                                                  .name
                                                  .toString(),
                                              code: dataList![index]
                                                  .code
                                                  .toString(),
                                              startDate: dataList![index]
                                                  .startDate
                                                  .toString(),
                                              endDate: dataList![index]
                                                  .endDate
                                                  .toString(),
                                              projectId:
                                                  dataList![index].projectId,
                                              createdAt:
                                                  dataList![index].createdAt,
                                              shareId: dataList![index]
                                                  .sharedProjectId,
                                              shareTo:
                                                  dataList![index].sharedTo,
                                              projectOwner:
                                                  dataList![index].owner,
                                              departmentId: dataList![index]
                                                  .sharedProjectDepartment,
                                              description:
                                                  dataList![index].description,
                                              departmentName:
                                                  dataList![index].deptName,
                                              sharedTo:
                                                  dataList![index].sharedToName,
                                              sharedBy:
                                                  dataList![index].projectOwner,
                                            ));
                                          },
                                          child: HRProjectsCard(
                                            ht: 250,
                                            wd: 400,
                                            duration: 400,
                                            name: dataList![index]
                                                .name
                                                .toString(),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            code: dataList![index]
                                                .code
                                                .toString(),
                                            startDate: dataList![index]
                                                .startDate
                                                .toString(),
                                            endDate: dataList![index]
                                                .endDate
                                                .toString(),
                                            createdAt: dataList![index]
                                                .createdAt
                                                .toString()
                                                .split("T")[0],
                                            deptName: dataList![index].deptName,
                                            sharedTo:
                                                dataList![index].sharedToName,
                                            sharedBy:
                                                dataList![index].projectOwner,
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
