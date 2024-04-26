import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_create_task_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/my_departments_controller.dart';

class HRCreateTask extends StatefulWidget {
  HRCreateTask({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HRCreateTask> createState() => _HRCreateTaskState();
}

class _HRCreateTaskState extends State<HRCreateTask> {
  final TextEditingController task = TextEditingController();
  final TextEditingController description = TextEditingController();

  //

  // final AllDepartmentList mdc = AllDepartmentList();  //not to use all but only my departments
  final MyDepartmentsController mdc = MyDepartmentsController();
  List<dynamic> deptNames = [];
  getData() async {
    await mdc.getMyDepartments();
    deptNames = await mdc.getMyDepartments();
    setState(() {});
  }

  final CreateTaskController ctc = Get.put(CreateTaskController());
  int? departmentId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
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
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(children: [
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: TextFormField(
                // controller: emailController,
                controller: task,
                // initialValue: widget.firstName,
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
                  labelText: 'Task name',
                  // hintText: 'username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter task name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextFormField(
                controller: description,
                // initialValue: widget.lastName,
                onChanged: (value) {
                  // AppController.setemailId(emailController.text);
                  // c.userName.value = emailController.text;
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
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
                  labelText: 'Select department',
                ),
                // value: widget.reportingManagerId,
                items: deptNames
                    .map((dept) => DropdownMenuItem<int>(
                          value: dept.id,
                          child: Text('${dept.deptName}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    departmentId = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Shimmer(
              duration: const Duration(seconds: 2),
              // This is NOT the default value. Default value: Duration(seconds: 0)
              interval: const Duration(seconds: 1),
              // This is the default value
              color: Colors.white,
              // This is the default value
              colorOpacity: 1,
              // This is the default value
              enabled: true,
              // This is the default value
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                height: 42,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    await ctc.createTask(
                        task.text, description.text, departmentId as int);
                    // }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      ),
                      Icon(
                        Icons.energy_savings_leaf,
                        color: Color.fromARGB(255, 78, 225, 83),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
      // backgroundColor: Colors.transparent,
    );
  }
}
