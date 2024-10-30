import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/bottom_navigations/user_is_manager_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_controllers/hr_delete_project_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

class DeleteReasonDialogBox_Project extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  final DeleteProjectController dpc = Get.put(DeleteProjectController());

  DeleteReasonDialogBox_Project({
    super.key,
    required this.projectId,
    this.remark,
  });

  final int? projectId;
  final String? remark;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: remark,
              validator: (value) {
                if (value == null || value.isEmpty || value == "") {
                  return 'Please add remark';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Remark',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // obscureText: true,
              controller: reasonController,
              // onChanged: (value) {
              //   vtc.remark.value = remarkController.text;
              // },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 195, 216, 201), // Change the button color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        if (reasonController.text.isNotEmpty) {
                          await dpc.deleteProject(
                            projectId!.toInt(),
                            reasonController.text,
                          );
                          toast(AppController.message);
                          if (AppController.role == 'hrManager') {
                            Get.offAll(const BottomNavHR(
                              initialIndex: 1,
                            ));
                          } else if (AppController.role == 'user' &&
                              AppController.isManager == 1) {
                            const BottomNavUsers(
                              initialIndex: 1,
                            );
                          }
                        } else {
                          toast('Please add remark');
                        }
                      } else {
                        toast('Please add remark');
                      }
                    } else {
                      // Handle case where form state is null
                      toast('Please add remark');
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),

                //

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 195, 216, 201), // Change the button color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    Get.back();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
