import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_task_by_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_timesheet_log_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_create_attribute_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_my_projects_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_tasks_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';
import 'package:timesheet/common/screens/hr_screens/dialog_create_timesheet.dart';
import 'package:timesheet/utils/widgets/log_data_diaolg_timesheet.dart';
import 'package:timesheet/utils/widgets/timesheet_log_cards.dart';

class CreateTimesheetScreen extends StatefulWidget {
  CreateTimesheetScreen({
    super.key,
    required this.title,
    required this.date1,
    required this.date2,
    required this.date3,
    required this.date4,
    required this.date5,
    required this.date6,
  });

  final String title;

  final String date1;
  final String date2;
  final String date3;
  final String date4;
  final String date5;
  final String date6;

  @override
  State<CreateTimesheetScreen> createState() => _CreateTimesheetScreenState();
}

enum StepEnabling { sequential, individual }

class _CreateTimesheetScreenState extends State<CreateTimesheetScreen> {
  final GetTimesheetLogController gtlc = GetTimesheetLogController();
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  // getUsersProjectsController upc = getUsersProjectsController();
  HRMyProjectsController mpc = HRMyProjectsController();
  final GetTaskByDeptIdController gtbydc = GetTaskByDeptIdController();
  final HRAttributesController ac = HRAttributesController();
  final HRTasksController allTasksCont = HRTasksController();

  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];
  List<dynamic> allTaskList = [];

  List<dynamic> AllLogDataList = [];

  int? departmentId;
  int? taskId;
  int? attributeId;

  getData() async {
    // await mpc.myProjects();
    projectList = await mpc.myProjects();
    // attributesList = await ac.attributes();
    // allTaskList = await allTasksCont.tasks();
    // deptNames = AllDepartmentList.verifiedDepartmentList;
    // setState(() {});
  }

  getAllAttributes() async {
    attributesList = await ac.attributes();
  }

  getAllTasks() async {
    allTaskList = await allTasksCont.tasks();
    setState(() {});
  }

  getTaskData() async {
    taskList = [];
    taskList =
        await GetTaskByDeptIdController.getTasksByDepId(departmentId!.toInt());
    // print(taskList);
    setState(() {});
    taskList;
  }

  addData() {
    TimesheetEntry newEntry = TimesheetEntry(
      description: "Dec-8",
      attrId: 3,
      // logId: 253,
      projectId: 6,
      taskDetails: {
        "2024-04-01": "2",
        "2024-04-02": "2",
        "2024-04-03": "2",
        "2024-04-04": "2",
        "2024-04-05": "2",
        "2024-04-06": "2",
      },
      taskId: 4,
    );

    // Add the new entry to the AllLogDataList
    AllLogDataList.add(newEntry);
    setState(() {});
  }

  final CreateAttributeController cac = Get.put(CreateAttributeController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getData();
    getAllAttributes();
    getAllTasks();
    gtlc;
    // addData();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await gtlc.getTimesheetLogData(widget.date1).then((value) {
        setState(() {
          AllLogDataList = value;
          // addData();    disabling as of now to avoid adding data
        });
      });

      //
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20),
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
                        onTap: () async {
                          Get.to(Dialog_create_timesheet_screen(
                            onAddNewEntry: addNewEntry,
                            date1: widget.date1,
                            date2: widget.date2,
                            date3: widget.date3,
                            date4: widget.date4,
                            date5: widget.date5,
                            date6:
                                widget.date6, // Pass the addNewEntry function
                          ));
                          // Get.to(Get.defaultDialog(
                          //   barrierDismissible: false,
                          //   backgroundColor:
                          //       const Color.fromARGB(255, 195, 215, 196),
                          //   title: 'Fill Timesheet',
                          //   content: const Dialog_create_timesheet_screen(),
                          // ));
                          // Show the bottom sheet
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return const Dialog_create_timesheet_screen();
                          //   },
                          // );
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
                                  'Add Timesheet +',
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
            Column(children: [
              Container(
                height: 500,
                child: Expanded(
                  child: Builder(builder: (
                    BuildContext context,
                  ) {
                    if (AllLogDataList == null || AllLogDataList!.isEmpty) {
                      return const Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text('No records found')],
                      ));
                    } else {
                      return ListView.builder(
                        itemCount: AllLogDataList!.length,
                        itemBuilder: (context, index) {
                          //For Project
                          var project = projectList.firstWhere(
                            (project) =>
                                project.id == AllLogDataList[index].projectId,
                          );
                          String projectName = project != null
                              ? project.name
                              : 'Unknown Project';

                          //For attribute
                          var attribute = attributesList.firstWhere(
                            (attribute) =>
                                attribute.id == AllLogDataList[index].attrId,
                          );
                          String attributeName = attribute != null
                              ? attribute.name
                              : 'Unknown attribute';

                          //For Tasks

                          //For attribute
                          var allTasks = allTaskList.firstWhere(
                            (task) => task.id == AllLogDataList[index].taskId,
                          );
                          String taskName = allTasks != null
                              ? allTasks.task
                              : 'Unknown attribute';

                          return GestureDetector(
                            onTap: () async {
                              // Get.to(Dialog_log_timesheet_screen(
                              //   projectName: projectName,
                              //   taskName: taskName,
                              //   attrName: attributeName,
                              //   projectId: snapshot.data[index].projectId,
                              //   taskId: snapshot.data[index].taskId,
                              //   attrId: snapshot.data[index].taskId,
                              // ));

                              Get.to(
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  backgroundColor:
                                      const Color.fromARGB(255, 195, 215, 196),
                                  title: 'Logged Timesheet',
                                  content: Dialog_log_timesheet_screen(
                                    projectName: projectName,
                                    taskName: taskName,
                                    attrName: attributeName,
                                    projectId: AllLogDataList[index].projectId,
                                    taskId: AllLogDataList[index].taskId,
                                    attrId: AllLogDataList[index].taskId,
                                    description:
                                        AllLogDataList[index].description,
                                    mon: AllLogDataList[index]
                                        .taskDetails[widget.date1]!,
                                    tue: AllLogDataList[index]
                                        .taskDetails[widget.date2]!,
                                    wed: AllLogDataList[index]
                                        .taskDetails[widget.date3]!,
                                    thu: AllLogDataList[index]
                                        .taskDetails[widget.date4]!,
                                    fri: AllLogDataList[index]
                                        .taskDetails[widget.date5]!,
                                    sat: AllLogDataList[index]
                                        .taskDetails[widget.date6]!,
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
                ),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  void addNewEntry(TimesheetEntry newEntry) {
    setState(() {
      AllLogDataList.add(newEntry);
    });
  }
}
