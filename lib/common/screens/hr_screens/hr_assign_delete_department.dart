import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'package:timesheet/common/controllers/hr_controllers/delete_user_dept_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/get_users_dept_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/getall_verified_departemnets.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_add_department_controller.dart';

class HRUserAssignAddDepartmentList extends StatefulWidget {
  HRUserAssignAddDepartmentList({Key? key, required this.title, this.id})
      : super(key: key);

  final String title;
  final int? id;

  @override
  State<HRUserAssignAddDepartmentList> createState() =>
      _HRUserAssignAddDepartmentListState();
}

class _HRUserAssignAddDepartmentListState
    extends State<HRUserAssignAddDepartmentList> {
  final AllDepartmentList allDeptCont = AllDepartmentList();
  final UsersDepartmentController usersDeptCont = UsersDepartmentController();
  final DeleteUserDeptController deleteDeptCont = DeleteUserDeptController();
  TextEditingController dept = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _selectedDepartmentIds = [];
  List<dynamic> deptNames = [];
  AddDepartmentController adc = AddDepartmentController();

  getData() async {
    deptNames = AllDepartmentList.verifiedDepartmentList;
  }

  @override
  void initState() {
    getData();
    allDeptCont.getAllDepartments();
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
                  // Shimmer(
                  //   duration: const Duration(seconds: 2),
                  //   // This is NOT the default value. Default value: Duration(seconds: 0)
                  //   interval: const Duration(milliseconds: 20),
                  //   // This is the default value
                  //   color: Colors.white,
                  //   // This is the default value
                  //   colorOpacity: 1,
                  //   // This is the default value
                  //   enabled: true,
                  //   // This is the default value
                  //   direction: const ShimmerDirection.fromLTRB(),
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       Get.to(
                  //         AddDepartmentScreen(
                  //           title: 'Add Department',
                  //           id: widget.id,
                  //         ),
                  //       );
                  //     },
                  //     child: Container(
                  //       height: 30,
                  //       width: 100,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(),
                  //           color: Colors.white70,
                  //           borderRadius: BorderRadius.circular(6)),
                  //       child: const Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Center(
                  //             child: Text(
                  //               'Add',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                        items: deptNames
                            .map(
                              (dept) => MultiSelectItem<String>(
                                  // dept.id,
                                  dept.id.toString(),
                                  dept.name),
                            )
                            .toList(),
                        initialValue: [],
                        onConfirm: (values) {
                          setState(() {
                            _selectedDepartmentIds = values;
                          });
                        },
                        title: const Text('Select Departments'),
                        buttonText: const Text('Select Departments'),
                        chipDisplay: MultiSelectChipDisplay<String>(
                          onTap: (item) {
                            setState(() {
                              _selectedDepartmentIds.remove(item);
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
                          await adc.addDepartment(
                              _selectedDepartmentIds, widget.id.toString());
                          setState(() {});
                          _selectedDepartmentIds.clear();
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
                if (_selectedDepartmentIds != null &&
                    _selectedDepartmentIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 8,
                      children: _selectedDepartmentIds.map((deptId) {
                        final dept = deptNames
                            .firstWhere((dept) => dept.id == int.parse(deptId));
                        return Chip(
                          label: Text(dept.name),
                          onDeleted: () {
                            setState(() {
                              _selectedDepartmentIds.remove(deptId);
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
            future: usersDeptCont.getAllDepartments(widget.id!.toInt()),
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
                      Text('Loading Departments...'),
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
                          '    Error loading departments\nPlease try again by logging out'),
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
                      Text('No Departments to show'),
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
                                '${snapshot.data[index].deptName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            int deptId = snapshot.data[index].id;
                            int userId = widget.id!.toInt();
                            await deleteDeptCont.deleteUserDept(userId, deptId);
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
