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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
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
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 195, 216, 201), // Change the button color here
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async {
            if (newPassController.text == confirmPassController.text) {
              await prc.changePassword();
              Get.back();
            } else {
              toast("Both passwords did not match!");
            }
          },
          child: const Text(
            "Update Password",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
