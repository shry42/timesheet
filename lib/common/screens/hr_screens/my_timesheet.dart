import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_all_projects_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_timesheet_progress_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_tasks_controller.dart';
import 'package:timesheet/common/screens/hr_screens/create_timesheet.dart';
import 'package:timesheet/common/screens/hr_screens/hr_myteam.dart';
import 'package:timesheet/common/screens/hr_screens/hr_profile_settings.dart';
import 'package:timesheet/utils/widgets/submitted_timesheet_dialog.dart';
import 'package:timesheet/utils/widgets/timesheet_log_cards.dart';

class MyTimesheetScreen extends StatefulWidget {
  const MyTimesheetScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyTimesheetScreen> createState() => _MyTimesheetScreenState();
}

final GetTimesheetStatusController gtsc = GetTimesheetStatusController();

class _MyTimesheetScreenState extends State<MyTimesheetScreen> {
  // HRMyProjectsController mpc = HRMyProjectsController();// disabling for now , beacuse some projects may be deleted and it will return null
  final AllProjectsController apc = AllProjectsController();
  final HRAttributesController ac = HRAttributesController();
  final HRTasksController allTasksCont = HRTasksController();

  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];
  List<dynamic> allTaskList = [];
  bool pick = false;

  String? date1 = 'Pick Date';
  String? date2;
  String? date3;
  String? date4;
  String? date5;
  String? date6;

  getData() async {
    // projectList = await mpc.myProjects();
    projectList = await apc.allProjects();
  }

  getAllAttributes() async {
    attributesList = await ac.attributes();
  }

  getAllTasks() async {
    allTaskList = await allTasksCont.tasks();
    setState(() {});
  }

  firstLoadData() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await gtsc.getTimesheetStatusData(date1.toString()).then((value) {
        setState(() {
          dataList = value;
          mainDataList = value;
        });
      });
    });
  }

  @override
  void initState() {
    getData();
    getAllAttributes();
    getAllTasks();
    firstLoadData();
    //
    // WidgetsBinding.instance?.addPostFrameCallback((_) async {
    //   await gtsc.getTimesheetStatusData(date1.toString()).then((value) {
    //     setState(() {
    //       dataList = value;
    //       mainDataList = value;
    //     });
    //   });
    // });
    pick = false;
    super.initState();
  }

  DateTime? selectedDate;
  List<dynamic> dataList = [];
  List<dynamic> searchDataList = [];
  List<dynamic> mainDataList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Exit?",
          middleText:
              "Are you sure?\nPlease Save first or else Timesheet entry will be lost",
          middleTextStyle: const TextStyle(fontSize: 18),
          textConfirm: 'Yes',
          textCancel: 'No',
          onConfirm: () {
            Get.back(result: true);
          },
          onCancel: () {
            DismissAction;
          },
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 213, 231, 214),
          body: Column(children: [
            const SizedBox(height: 18),
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
                          pick = true;
                          _selectDate(context, selectedDate ?? DateTime.now());
                        },
                        child: Container(
                          height: 30,
                          width: 65,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  '$date1',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    //
                    if (AppController.role == 'hrManager' ||
                        AppController.role == 'superAdmin' ||
                        AppController.isManager == 1)
                      Shimmer(
                        duration: const Duration(seconds: 2),
                        interval: const Duration(milliseconds: 20),
                        color: Colors.white,
                        colorOpacity: 1,
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        child: GestureDetector(
                          onTap: () {
                            AppController.setVerification(1);
                            Get.to(const MyTeamScreen(
                                title: 'Verify Team\'s Timesheet'));
                          },
                          child: Container(
                            height: 30,
                            width: 45,
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
                                    'Verify',
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
                    //
                    // if (AppController.role == 'hrManager')
                    Shimmer(
                      duration: const Duration(seconds: 2),
                      interval: const Duration(milliseconds: 20),
                      color: Colors.white,
                      colorOpacity: 1,
                      enabled: true,
                      direction: const ShimmerDirection.fromLTRB(),
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context, selectedDate ?? DateTime.now());
                        },
                        child: Container(
                          height: 30,
                          width: 50,
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
                                  'Fill',
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
                    if (AppController.role == 'user' &&
                        AppController.isManager != 1)
                      GestureDetector(
                          onTap: () {
                            Get.to(
                              const HRSettingsScreen(title: 'Profile'),
                            );
                          },
                          child: const CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Color.fromARGB(255, 120, 218, 130),
                              child: Icon(Icons.person))),
                  ],
                ),
              ),
            ),

            //
            Expanded(
              child: DefaultTabController(
                length: 3,
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
                            dataList = gtsc.approvedDataList;
                            searchDataList = dataList;
                            // searchController.clear();
                          });
                        } else if (index == 2) {
                          setState(() {
                            dataList = gtsc.rejectedDataList;
                            searchDataList = dataList;
                            // searchController.clear();
                          });
                        }
                        // else if (index == 3) {
                        //   // setState(() {
                        //   //   dataList = mainDataList
                        //   //       ?.where((element) => element.isVerified == 0)
                        //   //       .toList();
                        //   //   searchDataList = dataList;
                        //   //   // searchController.clear();
                        //   // });
                        // }
                      },
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      unselectedBackgroundColor: Colors.white70,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(243, 84, 86, 80),
                            Color.fromARGB(255, 151, 223, 126),
                          ],
                        ),
                      ),
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          icon: Icon(Icons.all_inbox),
                          text: "InProcess",
                        ),
                        Tab(
                          icon: Icon(Icons.approval),
                          text: "Approved",
                        ),
                        Tab(
                          icon: Icon(Icons.wrong_location_rounded),
                          text: "Rejected",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              '            No records found\nPick date above to view Timesheet')
                                        ],
                                      ));
                                    } else {
                                      return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          //For Project
                                          var project = projectList.firstWhere(
                                            (project) =>
                                                project.id ==
                                                dataList[index].projectId,
                                          );
                                          String projectName = project != null
                                              ? project.name
                                              : 'Unknown Project';

                                          //For attribute
                                          var attribute =
                                              attributesList.firstWhere(
                                            (attribute) =>
                                                attribute.id ==
                                                dataList[index].attrId,
                                          );
                                          String attributeName =
                                              attribute != null
                                                  ? attribute.name
                                                  : 'Unknown attribute';

                                          //For Tasks

                                          //For attribute
                                          var allTasks = allTaskList.firstWhere(
                                            (task) =>
                                                task.id ==
                                                dataList[index].taskId,
                                          );
                                          String taskName = allTasks != null
                                              ? allTasks.task
                                              : 'Unknown attribute';

                                          return GestureDetector(
                                            onTap: () async {
                                              Get.to(
                                                Get.defaultDialog(
                                                  barrierDismissible: false,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 195, 215, 196),
                                                  title: 'Submitted Timesheet',
                                                  content:
                                                      SubmittedTimesheetDialogScreen(
                                                    projectName: projectName,
                                                    taskName: taskName,
                                                    attrName: attributeName,
                                                    projectId: dataList[index]
                                                        .projectId!
                                                        .toInt(),
                                                    taskId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    attrId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    description: dataList[index]
                                                        .description
                                                        .toString(),
                                                    mon: dataList[index]
                                                        .taskDetails![date1]!,
                                                    tue: dataList[index]
                                                        .taskDetails![date2]!,
                                                    wed: dataList[index]
                                                        .taskDetails![date3]!,
                                                    thu: dataList[index]
                                                        .taskDetails![date4]!,
                                                    fri: dataList[index]
                                                        .taskDetails![date5]!,
                                                    sat: dataList[index]
                                                        .taskDetails![date6]!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: TimesheetLogCard(
                                              ht: 110,
                                              wd: 400,
                                              duration: 400,
                                              Project: projectName,
                                              Task: taskName,
                                              Attribute: attributeName,
                                            ),
                                          );
                                        },
                                      );
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(
                                          //   'assets/loaderr.gif',
                                          //   height: 200,
                                          //   width: 130,
                                          // ),
                                          Text(
                                              '               No records found\nPick date above to view Timesheet')
                                        ],
                                      ));
                                    } else {
                                      return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          //For Project
                                          var project = projectList.firstWhere(
                                            (project) =>
                                                project.id ==
                                                dataList[index].projectId,
                                          );
                                          String projectName = project != null
                                              ? project.name
                                              : 'Unknown Project';

                                          //For attribute
                                          var attribute =
                                              attributesList.firstWhere(
                                            (attribute) =>
                                                attribute.id ==
                                                dataList[index].attrId,
                                          );
                                          String attributeName =
                                              attribute != null
                                                  ? attribute.name
                                                  : 'Unknown attribute';

                                          //For Tasks

                                          //For attribute
                                          var allTasks = allTaskList.firstWhere(
                                            (task) =>
                                                task.id ==
                                                dataList[index].taskId,
                                          );
                                          String taskName = allTasks != null
                                              ? allTasks.task
                                              : 'Unknown attribute';

                                          return GestureDetector(
                                            onTap: () async {
                                              Get.to(
                                                Get.defaultDialog(
                                                  barrierDismissible: false,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 195, 215, 196),
                                                  title: 'Submitted Timesheet',
                                                  content:
                                                      SubmittedTimesheetDialogScreen(
                                                    projectName: projectName,
                                                    taskName: taskName,
                                                    attrName: attributeName,
                                                    projectId: dataList[index]
                                                        .projectId!
                                                        .toInt(),
                                                    taskId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    attrId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    description: dataList[index]
                                                        .description
                                                        .toString(),
                                                    mon: dataList[index]
                                                        .taskDetails![date1]!,
                                                    tue: dataList[index]
                                                        .taskDetails![date2]!,
                                                    wed: dataList[index]
                                                        .taskDetails![date3]!,
                                                    thu: dataList[index]
                                                        .taskDetails![date4]!,
                                                    fri: dataList[index]
                                                        .taskDetails![date5]!,
                                                    sat: dataList[index]
                                                        .taskDetails![date6]!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: TimesheetLogCard(
                                              ht: 110,
                                              wd: 400,
                                              duration: 400,
                                              Project: projectName,
                                              Task: taskName,
                                              Attribute: attributeName,
                                            ),
                                          );
                                        },
                                      );
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(
                                          //   'assets/loaderr.gif',
                                          //   height: 200,
                                          //   width: 130,
                                          // ),
                                          Text(
                                            '             No records found\nPick date above to view Timesheet',
                                          )
                                        ],
                                      ));
                                    } else {
                                      return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          //For Project
                                          var project = projectList.firstWhere(
                                            (project) =>
                                                project.id ==
                                                dataList[index].projectId,
                                          );
                                          String projectName = project != null
                                              ? project.name
                                              : 'Unknown Project';

                                          //For attribute
                                          var attribute =
                                              attributesList.firstWhere(
                                            (attribute) =>
                                                attribute.id ==
                                                dataList[index].attrId,
                                          );
                                          String attributeName =
                                              attribute != null
                                                  ? attribute.name
                                                  : 'Unknown attribute';

                                          //For Tasks

                                          //For attribute
                                          var allTasks = allTaskList.firstWhere(
                                            (task) =>
                                                task.id ==
                                                dataList[index].taskId,
                                          );
                                          String taskName = allTasks != null
                                              ? allTasks.task
                                              : 'Unknown attribute';

                                          return GestureDetector(
                                            onTap: () async {
                                              Get.to(
                                                Get.defaultDialog(
                                                  barrierDismissible: false,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 195, 215, 196),
                                                  title: 'Submitted Timesheet',
                                                  content:
                                                      SubmittedTimesheetDialogScreen(
                                                    projectName: projectName,
                                                    taskName: taskName,
                                                    attrName: attributeName,
                                                    projectId: dataList[index]
                                                        .projectId!
                                                        .toInt(),
                                                    taskId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    attrId: dataList[index]
                                                        .taskId!
                                                        .toInt(),
                                                    description: dataList[index]
                                                        .description
                                                        .toString(),
                                                    mon: dataList[index]
                                                        .taskDetails![date1]!,
                                                    tue: dataList[index]
                                                        .taskDetails![date2]!,
                                                    wed: dataList[index]
                                                        .taskDetails![date3]!,
                                                    thu: dataList[index]
                                                        .taskDetails![date4]!,
                                                    fri: dataList[index]
                                                        .taskDetails![date5]!,
                                                    sat: dataList[index]
                                                        .taskDetails![date6]!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: TimesheetLogCard(
                                              ht: 110,
                                              wd: 400,
                                              duration: 400,
                                              Project: projectName,
                                              Task: taskName,
                                              Attribute: attributeName,
                                            ),
                                          );
                                        },
                                      );
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
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    DateTime initialDate = DateTime.now();

    // If today is not Monday, find the next Monday
    if (selectedDate.weekday != 1) {
      int daysUntilNextMonday = (1 - selectedDate.weekday + 7) % 7;
      selectedDate = selectedDate.add(Duration(days: daysUntilNextMonday));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // Allow only Mondays to be selected
        return date.weekday == 1;
      },
    );

    if (picked != null) {
      // Create a new DateTime object with the same date as picked but time set to 00:00:00
      DateTime trimmedDate = DateTime(picked.year, picked.month, picked.day);

      // Format the date to '2024-04-01' format
      String formattedDate = DateFormat('yyyy-MM-dd').format(trimmedDate);

      // Get the next 5 dates in sequence
      List<DateTime> nextDates = getNextNDates(picked, 6);

      // Format each date to '2024-04-01' format
      List<String> formattedNextDates = nextDates.map((date) {
        return DateFormat('yyyy-MM-dd').format(date);
      }).toList();

      //Assign populated dates to the variables
      if (pick == true) {
        date1 = formattedDate;
        date2 = formattedNextDates[1];
        date3 = formattedNextDates[2];
        date4 = formattedNextDates[3];
        date5 = formattedNextDates[4];
        date6 = formattedNextDates[5];
        setState(() {});
        initState();
      } else {
        // Navigate to the next screen, passing the picked date and the next 5 dates
        Get.to(CreateTimesheetScreen(
          title: 'Logged Timesheet',
          date1: formattedDate,
          date2: formattedNextDates[1],
          date3: formattedNextDates[2],
          date4: formattedNextDates[3],
          date5: formattedNextDates[4],
          date6: formattedNextDates[5],
        ));
      }
    }
  }

  List<DateTime> getNextNDates(DateTime date, int n) {
    return List.generate(n, (i) => date.add(Duration(days: i)));
  }
}
