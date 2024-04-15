import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/screens/hr_screens/create_timesheet.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_tasks.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_tasks_card.dart';

class MyTimesheetScreen extends StatefulWidget {
  const MyTimesheetScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyTimesheetScreen> createState() => _MyTimesheetScreenState();
}

final HRAttributesController hac = HRAttributesController();

class _MyTimesheetScreenState extends State<MyTimesheetScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _selectDate(context, selectedDate ?? DateTime.now());
    });
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
                          _selectDate(context, selectedDate ?? DateTime.now());
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
                                  'Create Timesheet',
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
          const SizedBox(height: 10),
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
                        // setState(() {
                        //   dataList = mainDataList
                        //       ?.where((element) => element.isVerified == 1)
                        //       .toList();
                        //   searchDataList = dataList;
                        //   // searchController.clear();
                        // });
                      } else if (index == 2) {
                        // setState(() {
                        //   dataList = mainDataList
                        //       ?.where((element) => element.isVerified == 2)
                        //       .toList();
                        //   searchDataList = dataList;
                        //   // searchController.clear();
                        // });
                      } else if (index == 3) {
                        // setState(() {
                        //   dataList = mainDataList
                        //       ?.where((element) => element.isVerified == 0)
                        //       .toList();
                        //   searchDataList = dataList;
                        //   // searchController.clear();
                        // });
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
                                      children: [Text('No records found')],
                                    ));
                                  } else {
                                    return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              int taskId = dataList![index].id;
                                              String taskName =
                                                  dataList![index].task;
                                              String description =
                                                  dataList![index].description;
                                              String? remark =
                                                  dataList?[index].remark;
                                              if (AppController.role ==
                                                  'hrManager') {
                                                Get.to(HRUpdateTasks(
                                                  description: description,
                                                  taskName: taskName,
                                                  remark: remark.toString(),
                                                  taskId: taskId,
                                                  title: 'Update Task',
                                                ));
                                              }
                                            },
                                            child: HRTasksCard(
                                              ht: 120,
                                              wd: 400,
                                              duration: 400,
                                              // id: dataList![index].id.toString(),
                                              task: dataList![index]
                                                  .task
                                                  .toString(),
                                              createdAt: dataList![index]
                                                  .createdAt
                                                  .toString()
                                                  .split("T")[0],
                                              description: dataList![index]
                                                  .description
                                                  .toString(),
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
                                        Text('No records found')
                                      ],
                                    ));
                                  } else {
                                    return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              int taskId = dataList![index].id;
                                              String taskName =
                                                  dataList![index].task;
                                              String description =
                                                  dataList![index].description;
                                              String? remark =
                                                  dataList?[index].remark;
                                              if (AppController.role ==
                                                  'hrManager') {
                                                Get.to(HRUpdateTasks(
                                                  description: description,
                                                  taskName: taskName,
                                                  remark: remark.toString(),
                                                  taskId: taskId,
                                                  title: 'Update Task',
                                                ));
                                              }
                                            },
                                            child: HRTasksCard(
                                              ht: 120,
                                              wd: 400,
                                              duration: 400,
                                              // id: dataList![index].id.toString(),
                                              task: dataList![index]
                                                  .task
                                                  .toString(),
                                              createdAt: dataList![index]
                                                  .createdAt
                                                  .toString()
                                                  .split("T")[0],
                                              description: dataList![index]
                                                  .description
                                                  .toString(),
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
                                        Text('No records found')
                                      ],
                                    ));
                                  } else {
                                    return ListView.builder(
                                        itemCount: dataList!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              int taskId = dataList![index].id;
                                              String taskName =
                                                  dataList![index].task;
                                              String description =
                                                  dataList![index].description;
                                              String? remark =
                                                  dataList?[index].remark;
                                              if (AppController.role ==
                                                  'hrManager') {
                                                Get.to(HRUpdateTasks(
                                                  description: description,
                                                  taskName: taskName,
                                                  remark: remark.toString(),
                                                  taskId: taskId,
                                                  title: 'Update Task',
                                                ));
                                              }
                                            },
                                            child: HRTasksCard(
                                              ht: 120,
                                              wd: 400,
                                              duration: 400,
                                              // id: dataList![index].id.toString(),
                                              task: dataList![index]
                                                  .task
                                                  .toString(),
                                              createdAt: dataList![index]
                                                  .createdAt
                                                  .toString()
                                                  .split("T")[0],
                                              description: dataList![index]
                                                  .description
                                                  .toString(),
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

  List<DateTime> getNextNDates(DateTime date, int n) {
    return List.generate(n, (i) => date.add(Duration(days: i)));
  }
}
