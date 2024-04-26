import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_users_dept_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_my_projects_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/controllers/project_share_controllers/share_project_to_managers_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_users_model.dart';

class ShareProjectDialogScreen extends StatefulWidget {
  const ShareProjectDialogScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareProjectDialogScreen> createState() =>
      _ShareProjectDialogScreenState();
}

class _ShareProjectDialogScreenState extends State<ShareProjectDialogScreen> {
  HRMyProjectsController mpc = HRMyProjectsController();
  final HRUsersController hruc = HRUsersController();
  final UsersDepartmentController udc = UsersDepartmentController();
  final ShareProjectToManagerController sptmc =
      ShareProjectToManagerController();

  int? projectId;
  int? reportingManagerId;
  int? departmentId;

  List<dynamic> projectList = [];
  List<HRAllUsersListModel> hrUserListObj = [];
  List<dynamic> deptNames = [];

  getData() {
    projectList = HRMyProjectsController.verifiedprojectList;
    setState(() {});
  }

  getManagersData() {
    hrUserListObj = HRUsersController.managersList;
    setState(() {});
  }

  getDeptNames() async {
    deptNames = await udc.getAllDepartments(reportingManagerId!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    getManagersData();
  }

  //

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                    .map((project) => DropdownMenuItem<int>(
                          value: project.id,
                          child: Text('${project.name}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    projectId = value;
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
                  labelText: 'Select Reporting Manager',
                ),
                // value: widget.reportingManagerId,
                items: hrUserListObj
                    .map((user) => DropdownMenuItem<int>(
                          value: user.id,
                          child: Text('${user.firstName} ${user.lastName}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    reportingManagerId = value!;
                    getDeptNames();
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
                  labelText: 'Select Department',
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
                    departmentId = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            //Buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 209, 233, 181)),
                    onPressed: () async {
                      await sptmc.shareProject(
                        projectId.toString(),
                        reportingManagerId.toString(),
                        departmentId.toString(),
                      );
                      Get.back();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Share',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //
          ]),
        ),
      ],
    );
  }
}
