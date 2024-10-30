import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/hr_delete_controller.dart';
import 'package:timesheet/common/screens/reset_pass_screen.dart';
import 'package:timesheet/utils/toast_notify.dart';

class ForgotPassWithMailScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController empIdController = TextEditingController();
  final DeleteUserController duc = Get.put(DeleteUserController());

  ForgotPassWithMailScreen({
    super.key,
  });

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
                  return 'Please add Employee Id';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Employee Id',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // obscureText: true,
              controller: empIdController,
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
                    if (_formKey.currentState!.validate()) {
                      await Get.to(ResestPassScreenByOtpScreen(
                        empId: empIdController.text,
                      ));
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
