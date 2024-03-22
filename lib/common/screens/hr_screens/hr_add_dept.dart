import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/controllers/hr_controllers/getall_verified_departemnets.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_add_department_controller.dart';

class AddDepartmentScreen extends StatefulWidget {
  AddDepartmentScreen({super.key, required this.title, this.id});

  final String title;
  dynamic id;

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  final AllDepartmentList verifiedepCont = AllDepartmentList();
  TextEditingController dept = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _selectedDepartmentIds = [];
  List<dynamic> deptNames = [];
  AddDepartmentController adc = AddDepartmentController();

  getData() async {
    // deptNames = AllDepartmentList.verifiedDepartmentList
    //     .map((dept) => dept.name)
    //     .toList();
    deptNames = AllDepartmentList.verifiedDepartmentList;
    // setState(() {
    //   List deptList = deptNames;
    // });
  }

  @override
  void initState() {
    getData();
    verifiedepCont.getAllDepartments();
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
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ...[
                    const SizedBox(height: 17),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
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
                          buttonIcon:
                              const Icon(Icons.arrow_drop_down_outlined),
                        ),
                      ),
                    ),
                    // Display selected departments
                    if (_selectedDepartmentIds != null &&
                        _selectedDepartmentIds.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Wrap(
                          spacing: 8,
                          children: _selectedDepartmentIds.map((deptId) {
                            final dept = deptNames.firstWhere(
                                (dept) => dept.id == int.parse(deptId));
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
                  const SizedBox(height: 35),
                  Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(seconds: 1),
                    color: Colors.white,
                    colorOpacity: 1,
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: Container(
                      height: 42,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          // Call a method to add department
                          await adc.addDepartment(
                              _selectedDepartmentIds, widget.id.toString());
                          // }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
