import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_delete_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

class DeleteReasonDialogBox extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  final DeleteUserController duc = Get.put(DeleteUserController());

  DeleteReasonDialogBox({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value == "") {
                  return 'Please add delete reason';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Reason',
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
                          await duc.deleteUser(
                            userId,
                            reasonController.text,
                          );
                          toast(AppController.message);
                          Get.offAll(const BottomNavHR(
                            initialIndex: 0,
                          ));
                        } else {
                          toast('Please add delete reason');
                        }
                      } else {
                        toast('Please add delete reason');
                      }
                    } else {
                      // Handle case where form state is null
                      toast('Please add delete reason');
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
                  onPressed: () {
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
