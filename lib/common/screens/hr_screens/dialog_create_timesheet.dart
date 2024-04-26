import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_task_by_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_get_users_project_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';

class Dialog_create_timesheet_screen extends StatefulWidget {
  const Dialog_create_timesheet_screen(
      {Key? key,
      required this.onAddNewEntry,
      required this.date1,
      required this.date2,
      required this.date3,
      required this.date4,
      required this.date5,
      required this.date6})
      : super(key: key);
  final Function(TimesheetEntry) onAddNewEntry;
  final String date1;
  final String date2;
  final String date3;
  final String date4;
  final String date5;
  final String date6;

  @override
  State<Dialog_create_timesheet_screen> createState() =>
      _Dialog_create_timesheet_screenState();
}

class _Dialog_create_timesheet_screenState
    extends State<Dialog_create_timesheet_screen> {
  final getUsersProjectsController gupc = getUsersProjectsController();
  // HRMyProjectsController mpc = HRMyProjectsController();
  final GetTaskByDeptIdController gtbydc = GetTaskByDeptIdController();
  final HRAttributesController ac = HRAttributesController();
  int? projectId;
  int? departmentId;
  int? taskId;
  int? attributeId;

  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];

  getData() async {
    await gupc.getUsersProjects();
    projectList = getUsersProjectsController.usersProjectList;
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

  @override
  void initState() {
    date1Cont.text = widget.date1;
    date2Cont.text = widget.date2;
    date3Cont.text = widget.date3;
    date4Cont.text = widget.date4;
    date5Cont.text = widget.date5;
    date6Cont.text = widget.date6;

    getData();
    super.initState();
  }

  final TextEditingController date1Cont = TextEditingController();
  final TextEditingController date2Cont = TextEditingController();
  final TextEditingController date3Cont = TextEditingController();
  final TextEditingController date4Cont = TextEditingController();
  final TextEditingController date5Cont = TextEditingController();
  final TextEditingController date6Cont = TextEditingController();

  //
  TextEditingController monCont = TextEditingController();
  TextEditingController tueCont = TextEditingController();
  TextEditingController wedCont = TextEditingController();
  TextEditingController thuCont = TextEditingController();
  TextEditingController friCont = TextEditingController();
  TextEditingController satCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  //

  void addNewTimesheetEntry() {
    final monHours = int.tryParse(monCont.text) ?? 0;
    final tueHours = int.tryParse(tueCont.text) ?? 0;
    final wedHours = int.tryParse(wedCont.text) ?? 0;
    final thuHours = int.tryParse(thuCont.text) ?? 0;
    final friHours = int.tryParse(friCont.text) ?? 0;
    final satHours = int.tryParse(satCont.text) ?? 0;

    if (monHours > 8 ||
        tueHours > 8 ||
        wedHours > 8 ||
        thuHours > 8 ||
        friHours > 8 ||
        satHours > 8) {
      // Show an error message if any of the day's hours exceed 8
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('day\'s hours cannot exceed ')),
      );
      return;
    }

    if (projectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please select Project')),
      );
      return;
    }
    if (taskId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please select Task')),
      );
      return;
    }
    if (attributeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please select attribute')),
      );
      return;
    }
    if (descCont.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Description cannot be empty')),
      );
      return;
    }

    // Continue with adding the new timesheet entry
    TimesheetEntry newEntry = TimesheetEntry(
      projectId: projectId,
      taskId: taskId,
      attrId: attributeId,
      departmentId: departmentId,
      description: descCont.text,
      taskDetails: {
        date1Cont.text: monHours.toString(),
        date2Cont.text: tueHours.toString(),
        date3Cont.text: wedHours.toString(),
        date4Cont.text: thuHours.toString(),
        date5Cont.text: friHours.toString(),
        date6Cont.text: satHours.toString(),
      },
    );

    widget.onAddNewEntry(newEntry);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Timesheet'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  getData();
                },
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Select Project',
                  ),
                  // value: widget.reportingManagerId,
                  items: projectList
                      .fold<Map<int, String>>({}, (map, project) {
                        if (map.containsKey(project.projectId)) {
                          map[project.projectId] = '${project.projectName}';
                        } else {
                          map[project.projectId] = project.projectName;
                        }
                        return map;
                      })
                      .entries
                      .map((entry) => DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      departmentId = projectList
                          .firstWhere((project) => project.projectId == value)
                          .departmentId;

                      projectId = value;
                      getTaskData();
                    });
                  },
                ),
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
                  labelText: 'Select Task',
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
                  labelText: 'Select Attributes',
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
                        color: const Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: const Center(child: Text('Mon')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: monCont,
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
                        color: const Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: const Center(child: Text('Tue')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: tueCont,
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
                        color: Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Wed')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: wedCont,
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
                        color: Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Thu')),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: thuCont,
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
                        color: Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Fri')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: friCont,
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
                        color: Color.fromARGB(255, 175, 189, 158),
                      ),
                      height: 30,
                      width: 40,
                      child: Center(child: const Text('Sat')),
                    ),
                    SizedBox(height: 8),
                    Container(
                      // color: Colors.,
                      height: 30,
                      width: 40,
                      child: TextFormField(
                        controller: satCont,
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
                child: TextFormField(
                  controller: descCont,
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

            const SizedBox(
              height: 40,
            ),
            //
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
                      addNewTimesheetEntry();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Done',
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
                      // await Get.to(Get.defaultDialog(
                      //   backgroundColor:
                      //       const Color.fromARGB(255, 195, 215, 196),
                      //   title: 'Add Remark',
                      //   content: DialogBoxVerfiyRemarkTask(
                      //       taskId: widget.taskId, verify: '2'),
                      // ));

                      // // await VerifyProjectController()
                      // //     .verifyProject(widget.projectId!.toInt(), '1');
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
                            'Cancel',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            //
          ]),
        ),
      ),
    );
  }
}
