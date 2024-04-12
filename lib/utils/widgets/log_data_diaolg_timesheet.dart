import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dialog_log_timesheet_screen extends StatefulWidget {
  const Dialog_log_timesheet_screen(
      {super.key,
      required this.projectName,
      required this.taskName,
      required this.attrName,
      required this.projectId,
      required this.taskId,
      required this.attrId,
      required this.mon,
      required this.tue,
      required this.wed,
      required this.thu,
      required this.fri,
      required this.sat,
      required this.description});

  final String projectName;
  final String taskName;
  final String attrName;
  final String description;

  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;

  final int projectId;
  final int taskId;
  final int attrId;

  @override
  State<Dialog_log_timesheet_screen> createState() =>
      _Dialog_log_timesheet_screenState();
}

class _Dialog_log_timesheet_screenState
    extends State<Dialog_log_timesheet_screen> {
  // HRMyProjectsController mpc = HRMyProjectsController();
  // final GetTaskByDeptIdController gtbydc = GetTaskByDeptIdController();
  // final HRAttributesController ac = HRAttributesController();

  // int? departmentId;
  // int? taskId;
  // int? attributeId;

  // List<dynamic> projectList = [];
  // List<dynamic> taskList = [];
  // List<dynamic> attributesList = [];

  // getData() async {
  //   await mpc.myProjects();
  //   projectList = HRMyProjectsController.myProjectList;
  //   attributesList = await ac.attributes();
  //   // deptNames = AllDepartmentList.verifiedDepartmentList;
  //   setState(() {});
  // }

  // getTaskData() async {
  //   taskList = [];
  //   taskList =
  //       await GetTaskByDeptIdController.getTasksByDepId(departmentId!.toInt());
  //   // print(taskList);
  //   setState(() {});
  //   taskList;
  // }

  TextEditingController projectNamecont = TextEditingController();
  TextEditingController taskNamecont = TextEditingController();
  TextEditingController attrNamecont = TextEditingController();
  TextEditingController decriptionCont = TextEditingController();

  TextEditingController monCont = TextEditingController();
  TextEditingController tueCont = TextEditingController();
  TextEditingController wedCont = TextEditingController();
  TextEditingController thuCont = TextEditingController();
  TextEditingController friCont = TextEditingController();
  TextEditingController satCont = TextEditingController();

  //

  // TextEditingController mon2Cont = TextEditingController();
  // TextEditingController tue2Cont = TextEditingController();
  // TextEditingController wed2Cont = TextEditingController();
  // TextEditingController thu2Cont = TextEditingController();
  // TextEditingController fri2Cont = TextEditingController();
  // TextEditingController sat2Cont = TextEditingController();

  //

  // TextEditingController mon3Cont = TextEditingController();
  // TextEditingController tue3Cont = TextEditingController();
  // TextEditingController wed3Cont = TextEditingController();
  // TextEditingController thu3Cont = TextEditingController();
  // TextEditingController fri3Cont = TextEditingController();
  // TextEditingController sat3Cont = TextEditingController();

  // //
  // TextEditingController mon4Cont = TextEditingController();
  // TextEditingController tue4Cont = TextEditingController();
  // TextEditingController wed4Cont = TextEditingController();
  // TextEditingController thu4Cont = TextEditingController();
  // TextEditingController fri4Cont = TextEditingController();
  // TextEditingController sat4Cont = TextEditingController();

  // //

  // TextEditingController mon5Cont = TextEditingController();
  // TextEditingController tue5Cont = TextEditingController();
  // TextEditingController wed5Cont = TextEditingController();
  // TextEditingController thu5Cont = TextEditingController();
  // TextEditingController fri5Cont = TextEditingController();
  // TextEditingController sat5Cont = TextEditingController();
  // //

  // TextEditingController mon6Cont = TextEditingController();
  // TextEditingController tue6Cont = TextEditingController();
  // TextEditingController wed6Cont = TextEditingController();
  // TextEditingController thu6Cont = TextEditingController();
  // TextEditingController fri6Cont = TextEditingController();
  // TextEditingController sat6Cont = TextEditingController();
  //

  @override
  void initState() {
    // getData();

    projectNamecont.text = widget.projectName;
    taskNamecont.text = widget.taskName;
    attrNamecont.text = widget.attrName;
    decriptionCont.text = widget.description;

    monCont.text = widget.mon;
    tueCont.text = widget.tue;
    wedCont.text = widget.wed;
    thuCont.text = widget.thu;
    friCont.text = widget.fri;
    satCont.text = widget.sat;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              controller: projectNamecont,
              onChanged: (value) {
                // AppController.setemailId(emailController.text);
                // c.userName.value = emailController.text;
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Project Name ',
                // hintText: 'username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              controller: taskNamecont,
              onChanged: (value) {
                // AppController.setemailId(emailController.text);
                // c.userName.value = emailController.text;
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Task Name ',
                // hintText: 'username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: TextFormField(
              readOnly: true,
              controller: attrNamecont,
              onChanged: (value) {
                // AppController.setemailId(emailController.text);
                // c.userName.value = emailController.text;
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Attribute  Name ',
                // hintText: 'username',
              ),
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
                      color: Color.fromARGB(255, 175, 189, 158),
                    ),
                    height: 30,
                    width: 40,
                    child: Center(child: const Text('Tue')),
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
                  SizedBox(height: 8),
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
                  SizedBox(height: 8),
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
                  const SizedBox(height: 8),
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
                controller: decriptionCont,
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
      ),
    ]);
  }
}
