import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_all_projects_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_tasks_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/get_users_timesheet_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_users_timesheet_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';
import 'package:timesheet/utils/widgets/reject_verify_timesheet_dialog.dart';
import 'package:timesheet/utils/widgets/submitted_timesheet_dialog.dart';
import 'package:timesheet/utils/widgets/timesheet_log_cards.dart';

class VerifyUsersTimesheetScreen extends StatefulWidget {
  const VerifyUsersTimesheetScreen(
      {Key? key, required this.title, required this.userId})
      : super(key: key);
  final String title;

  final String userId;

  @override
  State<VerifyUsersTimesheetScreen> createState() =>
      _VerifyUsersTimesheetScreenState();
}

final GetUsersTimesheetController gutc = GetUsersTimesheetController();

class _VerifyUsersTimesheetScreenState
    extends State<VerifyUsersTimesheetScreen> {
  // HRMyProjectsController mpc = HRMyProjectsController();// disabling for now , beacuse some projects may be deleted and it will return null
  final AllProjectsController apc = AllProjectsController();
  final HRAttributesController ac = HRAttributesController();
  final HRTasksController allTasksCont = HRTasksController();

  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];
  List<dynamic> allTaskList = [];

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
      await gutc
          // .getUsersTimesheetData(widget.date1.toString(), widget.userId)
          .getUsersTimesheetData(date1.toString(), widget.userId)
          .then((value) {
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

    super.initState();
  }

  DateTime? selectedDate;
  List<dynamic> dataList = [];
  List<dynamic> searchDataList = [];
  List<dynamic> mainDataList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        _selectDate(context, selectedDate ?? DateTime.now());
                      },
                      child: Container(
                        height: 30,
                        width: 90,
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
                ],
              ),
            ),
          ),

          //
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Builder(
                    builder: (
                      BuildContext context,
                    ) {
                      if (dataList == null || dataList!.isEmpty) {
                        return const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  project.id == dataList[index].projectId,
                            );
                            String projectName = project != null
                                ? project.name
                                : 'Unknown Project';

                            //For attribute
                            var attribute = attributesList.firstWhere(
                              (attribute) =>
                                  attribute.id == dataList[index].attrId,
                            );
                            String attributeName = attribute != null
                                ? attribute.name
                                : 'Unknown attribute';

                            //For Tasks

                            //For attribute
                            var allTasks = allTaskList.firstWhere(
                              (task) => task.id == dataList[index].taskId,
                            );
                            String taskName = allTasks != null
                                ? allTasks.task
                                : 'Unknown attribute';

                            return GestureDetector(
                              onTap: () async {
                                Get.to(
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                    backgroundColor: const Color.fromARGB(
                                        255, 195, 215, 196),
                                    title: 'Submitted Timesheet',
                                    content: SubmittedTimesheetDialogScreen(
                                      projectName: projectName,
                                      taskName: taskName,
                                      attrName: attributeName,
                                      projectId:
                                          dataList[index].projectId!.toInt(),
                                      taskId: dataList[index].taskId!.toInt(),
                                      attrId: dataList[index].taskId!.toInt(),
                                      description: dataList[index]
                                          .description
                                          .toString(),
                                      mon: dataList[index].taskDetails![date1]!,
                                      tue: dataList[index].taskDetails![date2]!,
                                      wed: dataList[index].taskDetails![date3]!,
                                      thu: dataList[index].taskDetails![date4]!,
                                      fri: dataList[index].taskDetails![date5]!,
                                      sat: dataList[index].taskDetails![date6]!,
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
                    },
                  ),
                ),
                if (dataList.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          interval: const Duration(seconds: 1),
                          color: Colors.white,
                          colorOpacity: 1,
                          enabled: true,
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              // color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await VerifyUsersTimesheetController()
                                    .verifyTimesheet(
                                  int.parse(widget.userId),
                                  'Approved',
                                  date1.toString(),
                                  '',
                                );
                                if (AppController.message != null) {
                                  toast(AppController.message);
                                  Get.back();
                                  setState(() {
                                    initState();
                                  });
                                }
                                return;
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Approve',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          interval: const Duration(seconds: 1),
                          color: Colors.white,
                          colorOpacity: 1,
                          enabled: true,
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await Get.to(Get.defaultDialog(
                                  barrierDismissible: false,
                                  backgroundColor:
                                      const Color.fromARGB(255, 195, 215, 196),
                                  // title: 'Add Remark',
                                  content: DialogBoxVerfiyReasonTimesheet(
                                    userId: int.parse(widget.userId),
                                    date: date1.toString(),
                                  ),
                                ));
                                // await VerifyProjectController()
                                //     .verifyProject(widget.projectId!.toInt(), '1');
                                if (AppController.message != null) {
                                  Get.defaultDialog(
                                    // title: "Success!",
                                    middleText: "${AppController.message}",
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      AppController.setmessage(null);
                                      Get.back();
                                      setState(() {});
                                    },
                                  );
                                  return;
                                  // toast(AppController.message);
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          //
        ]),
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

      date1 = formattedDate;
      date2 = formattedNextDates[1];
      date3 = formattedNextDates[2];
      date4 = formattedNextDates[3];
      date5 = formattedNextDates[4];
      date6 = formattedNextDates[5];
      setState(() {});
      initState();
    }
  }

  List<DateTime> getNextNDates(DateTime date, int n) {
    return List.generate(n, (i) => date.add(Duration(days: i)));
  }
}
