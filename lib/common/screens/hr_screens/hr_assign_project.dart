import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_myteam_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_projects_users.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_add_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_assign_project_user_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_delete_project_user.dart';

class HRUserAssignAddProjectList extends StatefulWidget {
  HRUserAssignAddProjectList(
      {Key? key, required this.title, this.projectId, required this.code})
      : super(key: key);

  final String title, code;
  final int? projectId;

  @override
  State<HRUserAssignAddProjectList> createState() =>
      _HRUserAssignAddProjectListState();
}

class _HRUserAssignAddProjectListState
    extends State<HRUserAssignAddProjectList> {
  final MyTeamListController mtlc = MyTeamListController();
  final ProjectsUsersController puc = ProjectsUsersController();
  final DeleteProjectUsersController deleteProjCont =
      DeleteProjectUsersController();
  final AssignProjectUsesrController apuc = AssignProjectUsesrController();
  TextEditingController dept = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _selectedUserIds = [];
  List<dynamic> myTeamList = [];
  List<dynamic> projectUsersList = [];

  AddDepartmentController adc = AddDepartmentController();

  getData() async {
    myTeamList = await mtlc.getMyTeamList();
    setState(() {});
    // projectUsersList = puc.getProjectsUsers(widget.projectId!.toInt());
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: Column(
        children: [
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //

          Column(
            children: [
              ...[
                const SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MultiSelectDialogField<String>(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please select at least one department';
                        //   }
                        //   return null;
                        // },
                        searchable: true,
                        items: myTeamList
                            .map(
                              (id) => MultiSelectItem<String>(
                                id.id.toString(),
                                '${id.firstName} ${id.lastName}',
                              ),
                            )
                            .toList(),
                        initialValue: [],
                        onConfirm: (values) {
                          setState(() {
                            _selectedUserIds = values;
                            apuc.selectedUserIds.value = values;
                          });
                        },
                        title: const Text('Select Users'),
                        buttonText: const Text('Select Users to Assign'),
                        chipDisplay: MultiSelectChipDisplay<String>(
                          onTap: (item) {
                            setState(() {
                              _selectedUserIds.remove(item);
                            });
                          },
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        buttonIcon: const Icon(Icons.arrow_drop_down_outlined),
                      ),
                    ),
                    SizedBox(width: 25),
                    Container(
                      height: 42,
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius to zero
                            ),
                            backgroundColor:
                                const Color.fromARGB(136, 249, 249, 249)),
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          // Call a method to add department

                          await apuc.assignProjectUsers(
                              widget.projectId!.toInt(),
                              widget.code.toString());
                          setState(() {});
                          // }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Display selected departments
                if (_selectedUserIds != null && _selectedUserIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 8,
                      children: _selectedUserIds.map((id) {
                        final name = myTeamList
                            .firstWhere((name) => name.id == int.parse(id));
                        return Chip(
                          label: Text('${name.firstName} ${name.lastName}'),
                          onDeleted: () {
                            setState(() {
                              _selectedUserIds.remove(id);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ],
          ),
          //
          FutureBuilder(
            future: puc.getProjectsUsers(widget.projectId!.toInt()),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading project users...'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(height: 60),
                      Text(
                          '    Error loading project users\nPlease try again by logging out'),
                    ],
                  ),
                );
              } else if (snapshot.data == null || snapshot.data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 65),
                      Text('No project\'s users to show'),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 175, 233, 108),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                '${snapshot.data[index].firstName}  ${snapshot.data[index].lastName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            int projectId = widget.projectId!.toInt();
                            int userId = snapshot.data[index].userId;
                            await deleteProjCont.deleteProjectUsers(
                                projectId, userId);
                            setState(() {});
                          },
                          // child: (snapshot.data[index].id !=
                          //             AppController.mainUid) &&
                          //         AppController.role != 'superAdmin'
                          //     ? const Icon(Icons.delete)
                          //     : const SizedBox()),
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
