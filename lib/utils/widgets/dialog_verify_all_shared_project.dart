import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/superadmin_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_all_shared_project_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

class DialogBoxVerfiyAllSharedProject extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController remarkController = TextEditingController();
  final VerifyAllSharedProjectController vtc =
      Get.put(VerifyAllSharedProjectController());

  DialogBoxVerfiyAllSharedProject({
    required this.projectId,
    required this.shareId,
    required this.sharedTo,
    required this.projectOwner,
    required this.departmentId,
    required this.verify,
    required this.projectCode,
    required this.remark,
    super.key,
  });
  int? projectId, shareId, sharedTo, projectOwner, departmentId;
  String? verify, projectCode, remark;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
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
              controller: remarkController,
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
                        if (remarkController.text.isNotEmpty) {
                          await VerifyAllSharedProjectController()
                              .verifyAllSharedProject(
                            projectId!.toInt(),
                            shareId,
                            sharedTo,
                            projectOwner,
                            departmentId,
                            verify.toString(),
                            projectCode,
                            remarkController.text,
                          );
                          toast(AppController.message);
                          Get.offAll(const BottomNavSuperAdmin(
                            initialIndex: 1,
                          ));
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
