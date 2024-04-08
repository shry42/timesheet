import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_task_by_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_create_attribute_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_get_users_project_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_my_projects_controller.dart';

class CreateTimesheetScreen extends StatefulWidget {
  CreateTimesheetScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CreateTimesheetScreen> createState() => _CreateTimesheetScreenState();
}

class _CreateTimesheetScreenState extends State<CreateTimesheetScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();

  //

  // getUsersProjectsController upc = getUsersProjectsController();
  HRMyProjectsController mpc = HRMyProjectsController();
  final GetTaskByDeptIdController gtbydc = GetTaskByDeptIdController();
  final HRAttributesController ac = HRAttributesController();
  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];

  int? departmentId;
  int? taskId;
  int? attributeId;

  getData() async {
    await mpc.myProjects();
    projectList = HRMyProjectsController.myProjectList;
    attributesList = await ac.attributes();
    // deptNames = AllDepartmentList.verifiedDepartmentList;
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

  final CreateAttributeController cac = Get.put(CreateAttributeController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: SingleChildScrollView(
        child: Column(children: [
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
                        // Get.to(CreateTimesheetScreen(title: 'Fill Timesheet'));
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
                                'Add more',
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
          const SizedBox(height: 30),
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Project Name',
                ),
                // value: widget.reportingManagerId,
                items: projectList
                    .map((project) => DropdownMenuItem<int>(
                          value: project.id,
                          child: Text('${project.name}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    departmentId = projectList
                        .firstWhere((project) => project.id == value)
                        .departmentId;
                    getTaskData();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Task',
                ),
                // value: widget.reportingManagerId,
                items: taskList
                    .map((task) => DropdownMenuItem<int>(
                          value: task.id,
                          child: Text('${task.task}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    taskId = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Attributes',
                ),
                // value: widget.reportingManagerId,
                items: attributesList
                    .map((attribute) => DropdownMenuItem<int>(
                          value: attribute.id,
                          child: Text('${attribute.name}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    attributeId = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: const Center(child: Text('Mon')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: Center(child: const Text('Tue')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: Center(child: const Text('Wed')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
              ],
            ),

            //SECOND ROW

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: Center(child: const Text('Thu')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: Center(child: const Text('Fri')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 183, 210, 151),
                      ),
                      height: 30,
                      width: 60,
                      child: Center(child: const Text('Sat')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 60,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'hrs'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                ),
                //
              ],
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 150,
                width: 400,
                child: TextField(
                  textAlign: TextAlign.center,
                  // controller: _description,
                  decoration: InputDecoration(
                    hintText: 'Enter description here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 200,
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 118,
                decoration: BoxDecoration(
                  // color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // await VerifyDepartmentController()
                    //     .VerifyDepartment(widget.deptId, '1', '');
                    // if (AppController.message != null) {
                    //   Get.defaultDialog(
                    //     title: "Success!",
                    //     middleText: "${AppController.message}",
                    //     textConfirm: "OK",
                    //     confirmTextColor: Colors.white,
                    //     onConfirm: () async {
                    //       AppController.setmessage(null);
                    //       Get.offAll(const BottomNavHR(
                    //         initialIndex: 2,
                    //       ));
                    //     },
                    //   );
                    //   return;
                    // }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 118,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // await Get.to(
                    //   Get.defaultDialog(
                    //     backgroundColor:
                    //         const Color.fromARGB(255, 195, 215, 196),
                    //     title: 'Add Remark',
                    //     content: DialogBoxVerfiyRemarkDept(
                    //       verify: '2',
                    //       departmentId: widget.deptId,
                    //     ),
                    //   ),
                    // );

                    // await VerifyProjectController()
                    //     .verifyProject(widget.projectId!.toInt(), '1');
                    // if (AppController.message != null) {
                    //   Get.defaultDialog(
                    //     title: "Success!",
                    //     middleText: "${AppController.message}",
                    //     textConfirm: "OK",
                    //     confirmTextColor: Colors.white,
                    //     onConfirm: () async {
                    //       AppController.setmessage(null);
                    //       Get.offAll(const BottomNavHR(
                    //         initialIndex: 3,
                    //       ));
                    //     },
                    //   );
                    //   return;
                    //   // toast(AppController.message);
                    // }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      // backgroundColor: Colors.transparent,
    );
  }
}
