import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/controllers/superadmin_controllers/verify_dept_controller.dart';
import 'package:timesheet/utils/toast_notify.dart';

class DialogBoxVerfiyRemarkDept extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController remarkController = TextEditingController();
  final VerifyDepartmentController vdc = Get.put(VerifyDepartmentController());

  DialogBoxVerfiyRemarkDept({
    super.key,
    required this.verify,
    required this.departmentId,
  });

  final int departmentId;
  final String verify;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
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
            controller: remarkController,
            // onChanged: (value) {
            //   vtc.remark.value = remarkController.text;
            // },
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
                if (remarkController.text.isNotEmpty) {
                  await VerifyDepartmentController().VerifyDepartment(
                    departmentId,
                    verify,
                    remarkController.text,
                  );
                  toast(AppController.message);
                  Get.offAll(const BottomNavHR(
                    initialIndex: 3,
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
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
