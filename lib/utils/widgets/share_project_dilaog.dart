import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_users_dept_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_my_projects_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_users_controller.dart';
import 'package:timesheet/common/controllers/project_share_controllers/share_project_to_managers_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_users_model.dart';
import 'package:timesheet/utils/toast_notify.dart';

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
  HRUsersController hruc = HRUsersController();
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
    if (projectList.isEmpty) {
      toast('create project first');
    }
    setState(() {});
  }

  getManagersData() {
    hrUserListObj = HRUsersController.managersListwithoutTheirName;
    setState(() {});
  }

  getDeptNames() async {
    deptNames = await udc.getAllDepartments(reportingManagerId!);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    HRUsersController();
    getManagersData();
    super.initState();
  }

  //

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select project';
                    }
                    return null;
                  },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select reporting Manager';
                    }
                    return null;
                  },
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
                      deptNames = [];
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Department';
                    }
                    return null;
                  },
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
                        if (_formKey.currentState!.validate()) {
                          await sptmc.shareProject(
                            projectId.toString(),
                            reportingManagerId.toString(),
                            departmentId.toString(),
                          );
                          Get.back();
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Share',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
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
                        Get.back();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
        ),
      ],
    );
  }
}
