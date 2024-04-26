import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';

class CreateProjectController extends GetxController {
  RxString selectedStartDate = ''.obs;
  RxString selectedEndDate = ''.obs;

  Future createProject(String name, description, code, startDate, endDate,
      int departmentId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/project/createProject'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "name": name,
        "description": description,
        "code": code,
        // "startDate": selectedStartDate.value.split(' ')[0],
        // "endDate": selectedEndDate.value.split(' ')[0],
        "startDate": startDate,
        "endDate": endDate,
        "departmentId": departmentId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];

      if (status == true) {
        Get.defaultDialog(
          title: "Success",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(const BottomNavHR(
              initialIndex: 1,
            ));
          },
        );
      }
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String title = result['title'];
      String message = result['message'];

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          title: "Error",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      } else if (title == 'Unauthorized') {
        Get.defaultDialog(
          title: "Error",
          middleText: "$message \nplease re login",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginPage());
            // Get.back(); // Close the dialog
          },
        );
      } else if (title == 'Server Error') {
        Get.defaultDialog(
          title: "Error",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      }
    }
  }
}
