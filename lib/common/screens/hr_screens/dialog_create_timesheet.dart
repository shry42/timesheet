import 'package:flutter/material.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_task_by_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_attributes_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_my_projects_controller.dart';

class Dialog_create_timesheet_screen extends StatefulWidget {
  const Dialog_create_timesheet_screen({super.key});

  @override
  State<Dialog_create_timesheet_screen> createState() =>
      _Dialog_create_timesheet_screenState();
}

class _Dialog_create_timesheet_screenState
    extends State<Dialog_create_timesheet_screen> {
  HRMyProjectsController mpc = HRMyProjectsController();
  final GetTaskByDeptIdController gtbydc = GetTaskByDeptIdController();
  final HRAttributesController ac = HRAttributesController();

  int? departmentId;
  int? taskId;
  int? attributeId;

  List<dynamic> projectList = [];
  List<dynamic> taskList = [];
  List<dynamic> attributesList = [];

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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                  color: Color.fromARGB(255, 175, 189, 158),
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
              SizedBox(height: 8),
              Container(
                // color: Colors.,
                height: 30,
                width: 40,
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            maxLines: 200,
          ),
        ),
      ),
    ]);
  }
}
