import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_task_by_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_tasks_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/my_departments_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_task_controller.dart';
import 'package:timesheet/common/screens/hr_screens/hr_create_tasks.dart';
import 'package:timesheet/common/screens/hr_screens/hr_update_tasks.dart';
import 'package:timesheet/common/screens/superadmin_screens/verify_task_screen.dart';
import 'package:timesheet/utils/widgets/hr_cards/hr_tasks_card.dart';
import 'package:timesheet/utils/widgets/reject_verify_dialog_task.dart';

class HRMyTasks extends StatefulWidget {
  const HRMyTasks({super.key, required this.title});

  final String title;

  @override
  State<HRMyTasks> createState() => _HRMyTasksState();
}

class _HRMyTasksState extends State<HRMyTasks> {
  final HRUsersController hrUc = HRUsersController();
  final MyDepartmentsController gmd =
      MyDepartmentsController(); //get my departments list
  final GetTaskByDeptIdController gtbdc =
      GetTaskByDeptIdController(); //tasks by dept id controller

  final HRTasksController htc = HRTasksController();

  int? deptId;
  List<dynamic> departmentList = [];
  List<dynamic>? dataList;
  List? searchDataList;
  List? mainDataList;
  String? departmentName;

  getDeptList() async {
    departmentList = await gmd.getMyDepartments();
  }

  late ValueNotifier<int?> _deptIdNotifier;

  @override
  void initState() {
    dataList; //Initialize as empty or else data will not be displayed until tapped on searchbar
    departmentList;
    htc;
    gtbdc;
    getDeptList();
    _deptIdNotifier = ValueNotifier(null);

    if (AppController.role == "superAdmin") {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await htc.tasks().then((value) {
          setState(() {
            dataList = value;
            mainDataList = value;
          });
        });
      });
    } else if (AppController.isManager == 1) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await gmd.getMyDepartments().then((value) {
          setState(() {
            departmentList = value;
            deptId = value.isNotEmpty ? value[0].id : null;
            departmentName = value[0].deptName;
          });
          GetTaskByDeptIdController.getTasksByDepId(deptId!.toInt())
              .then((value) {
            setState(() {
              dataList = value;
              mainDataList = value;
            });
          });
        });
      });
    }
    super.initState();
  }

  List<int> _selectedTaskIds = [];

  @override
  Widget build(BuildContext context) {
    print(_selectedTaskIds);
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

//
                if (AppController.role != 'superAdmin')
                  Container(
                    width: 130,
                    height: 35,
                    child: DropdownButtonFormField<int?>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      value: deptId, // Set the initial value
                      onChanged: (value) {
                        setState(() {
                          deptId = value;
                          departmentName = departmentList
                              .firstWhere((element) => element.id == value)
                              .deptName;
                        });
                        GetTaskByDeptIdController.getTasksByDepId(
                                deptId!.toInt())
                            .then((value) {
                          setState(() {
                            dataList = value;
                            mainDataList = value;
                          });
                        });
                      },
                      items: departmentList
                          .map((dep) => DropdownMenuItem<int?>(
                                value: dep.id,
                                // child: SizedBox(
                                //   height: 40, // Increase the height here
                                //   child: Text(dep.deptName,
                                //       style: TextStyle(fontSize: 10)),
                                // ),
                                child: Text(
                                  dep.deptName,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
//

                const SizedBox(width: 10),
                // if (AppController.role == 'hrManager' ||
                //     AppController.isManager == 1)
                if (AppController.role != 'superAdmin')
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
                        Get.to(HRCreateTask(title: 'Create Tasks'));
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
                                'Create Tasks',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                            createdAt: DateFormat('yyyy-MM-dd')
                                                .format(
                                                    dataList![index].createdAt),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            // remark: dataList![index]
                                            //     .remark
                                            //     .toString(),
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
                                            createdAt: DateFormat('yyyy-MM-dd')
                                                .format(
                                                    dataList![index].createdAt),
                                            description: dataList![index]
                                                .description
                                                .toString(),
                                            // remark: dataList![index]
                                            //     .remark
                                            //     .toString(),
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
                                            createdAt: DateFormat('yyyy-MM-dd')
                                                .format(
                                                    dataList![index].createdAt),
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
                                        if (AppController.role ==
                                            'superAdmin') {
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
                                              if (AppController.role ==
                                                  'superAdmin') {
                                                Get.to(VerifyTaskScreen(
                                                  selectedTaskIds:
                                                      _selectedTaskIds,
                                                  description: description,
                                                  taskName: taskName,
                                                  remark: remark.toString(),
                                                  taskId: taskId,
                                                  title: 'Verify Task',
                                                  createdAt:
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              dataList![index]
                                                                  .createdAt),
                                                ));
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value:
                                                      _selectedTaskIds.contains(
                                                          dataList![index].id),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        _selectedTaskIds.add(
                                                            dataList![index]
                                                                .id);
                                                      } else {
                                                        _selectedTaskIds.remove(
                                                            dataList![index]
                                                                .id);
                                                      }
                                                    });
                                                  },
                                                ),
                                                HRTasksCard(
                                                  ht: 110,
                                                  wd: 260,
                                                  duration: 400,
                                                  // id: dataList![index].id.toString(),
                                                  task: dataList![index]
                                                      .task
                                                      .toString(),
                                                  createdAt:
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              dataList![index]
                                                                  .createdAt),
                                                  description: dataList![index]
                                                      .description
                                                      .toString(),
                                                  // remark: dataList![index].remark.toString(),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
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
                                              if (AppController.role ==
                                                  'superAdmin') {
                                                Get.to(VerifyTaskScreen(
                                                  selectedTaskIds:
                                                      _selectedTaskIds,
                                                  description: description,
                                                  taskName: taskName,
                                                  remark: remark.toString(),
                                                  taskId: taskId,
                                                  title: 'Verify Task',
                                                  createdAt:
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              dataList![index]
                                                                  .createdAt),
                                                ));
                                              }
                                            },
                                            child: HRTasksCard(
                                              ht: 110,
                                              wd: 400,
                                              duration: 400,
                                              // id: dataList![index].id.toString(),
                                              task: dataList![index]
                                                  .task
                                                  .toString(),
                                              createdAt:
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(dataList![index]
                                                          .createdAt),
                                              description: dataList![index]
                                                  .description
                                                  .toString(),
                                              // remark: dataList![index].remark.toString(),
                                            ),
                                          );
                                        }
                                      });
                                }
                              }),
                            ),
                            if (AppController.role == 'superAdmin')
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Shimmer(
                                        duration: const Duration(seconds: 2),
                                        interval: const Duration(seconds: 1),
                                        color: Colors.white,
                                        colorOpacity: 1,
                                        enabled: true,
                                        direction:
                                            const ShimmerDirection.fromLTRB(),
                                        child: Container(
                                          height: 40,
                                          width: 118,
                                          decoration: BoxDecoration(
                                            // color: Colors.greenAccent,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await VerifyTaskController()
                                                  .verifyTask(
                                                      _selectedTaskIds as List,
                                                      '1',
                                                      '');
                                              if (AppController.message !=
                                                  null) {
                                                Get.defaultDialog(
                                                  // title: "Success!",
                                                  middleText:
                                                      "${AppController.message}",
                                                  textConfirm: "OK",
                                                  confirmTextColor:
                                                      Colors.white,
                                                  onConfirm: () async {
                                                    AppController.setmessage(
                                                        null);
                                                    Get.offAll(
                                                        const BottomNavHR(
                                                      initialIndex: 3,
                                                    ));
                                                  },
                                                );
                                                return;
                                              }
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Approve',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
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
                                        direction:
                                            const ShimmerDirection.fromLTRB(),
                                        child: Container(
                                          height: 40,
                                          width: 118,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await Get.to(Get.defaultDialog(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 195, 215, 196),
                                                title: 'Add Remark',
                                                content:
                                                    DialogBoxVerfiyRemarkTask(
                                                        taskId: _selectedTaskIds
                                                            as List,
                                                        verify: '2'),
                                              ));

                                              // await VerifyProjectController()
                                              //     .verifyProject(widget.projectId!.toInt(), '1');
                                              if (AppController.message !=
                                                  null) {
                                                Get.defaultDialog(
                                                  title: "Success!",
                                                  middleText:
                                                      "${AppController.message}",
                                                  textConfirm: "OK",
                                                  confirmTextColor:
                                                      Colors.white,
                                                  onConfirm: () async {
                                                    AppController.setmessage(
                                                        null);
                                                    Get.offAll(
                                                        const BottomNavHR(
                                                      initialIndex: 3,
                                                    ));
                                                  },
                                                );
                                                return;
                                                // toast(AppController.message);
                                              }
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
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
