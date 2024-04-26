import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_users_timesheet_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

// ignore: must_be_immutable
class DialogBoxVerfiyReasonTimesheet extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  final VerifyUsersTimesheetController vutc =
      Get.put(VerifyUsersTimesheetController());

  DialogBoxVerfiyReasonTimesheet({
    super.key,
    required this.userId,
    required this.date,
  });

  final int userId;
  final String date;

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
                if (value == null || value.isEmpty) {
                  return 'Please add reason';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              controller: reasonController,
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
              if (_formKey.currentState != null) {
                if (_formKey.currentState!.validate()) {
                  if (reasonController.text.isNotEmpty) {
                    await vutc.verifyTimesheet(
                        userId, 'Rejected', date, reasonController.text);
                    toast(AppController.message);
                    Get.back();
                  } else {
                    toast('Please add reason');
                  }
                } else {
                  toast('Please add reason');
                }
              } else {
                // Handle case where form state is null
                toast('Please add reason');
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
        ],
      ),
    );
  }
}
