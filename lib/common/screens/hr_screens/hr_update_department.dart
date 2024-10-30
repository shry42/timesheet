import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/delete_department_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_update_department_controller.dart';

class HRUpdateDepartment extends StatefulWidget {
  HRUpdateDepartment({
    super.key,
    required this.title,
    required this.deptName,
    required this.deptId,
  });

  final String title, deptName;
  int deptId;

  @override
  State<HRUpdateDepartment> createState() => _HRUpdateDepartmentState();
}

class _HRUpdateDepartmentState extends State<HRUpdateDepartment> {
  final UpdateDepartmentController udc = UpdateDepartmentController();

  final TextEditingController deptNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the provided values
    deptNameController.text = widget.deptName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 231, 214),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      interval: const Duration(milliseconds: 20),
                      color: Colors.white,
                      colorOpacity: 1,
                      enabled: true,
                      direction: const ShimmerDirection.fromLTRB(),
                      child: GestureDetector(
                        onTap: () async {
                          await DeleteDepartmentController()
                              .deleteDepartment(widget.deptId);
                          if (AppController.message != null) {
                            Get.defaultDialog(
                              title: "Success!",
                              middleText: "${AppController.message}",
                              textConfirm: "OK",
                              confirmTextColor: Colors.white,
                              onConfirm: () async {
                                AppController.setmessage(null);
                                Get.offAll(const BottomNavHR(
                                  initialIndex: 2,
                                ));
                              },
                            );
                            return;
                          }
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
                                  'Delete department',
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
            const SizedBox(height: 50),
            Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: TextFormField(
                  controller: deptNameController,
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
                    labelText: 'Department Name',

                    // hintText: 'username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Department name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 35),
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
                      if (_formKey.currentState!.validate()) {
                        await udc.updateDepartment(
                            widget.deptId, deptNameController.text);
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Update',
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
      ),
    );
  }
}
