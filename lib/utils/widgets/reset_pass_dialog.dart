import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/controllers/reset_password_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

class DialogBox extends StatelessWidget {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  // final PasswordController pc = Get.put(PasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordResetcontroller prc = PasswordResetcontroller();
  DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  } else if (!RegExp(
                          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$')
                      .hasMatch(value)) {
                    return "Please enter a valid password (must be at least 8 characters long, contain 1 special character, 1 capital letter, and 1 number)";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                controller: newPassController,
                onChanged: (value) {
                  prc.newPassword.value = newPassController.text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please re enter password";
                  } else if (newPassController.text !=
                      confirmPassController.text) {
                    return "Password mismatch";
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: confirmPassController,
                obscureText: true,
                onChanged: (value) {
                  prc.confirmPssword.value = confirmPassController.text;
                },
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
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
                        if (newPassController.text ==
                            confirmPassController.text) {
                          await prc.changePassword();
                          Get.back();
                        } else {
                          toast("Both passwords did not match!");
                        }
                      }
                    },
                    child: const Text(
                      "Update",
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
      ),
    );
  }
}
