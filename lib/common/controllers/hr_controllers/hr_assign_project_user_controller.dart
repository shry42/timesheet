import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class AssignProjectUsesrController extends GetxController {
  RxList selectedUserIds = [].obs;

  Future assignProjectUsers(
      int projectId, String projectCode, departmentId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/project/assignProject'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "projectId": projectId,
        "projectCode": projectCode,
        "userIds": selectedUserIds.value,
        "departmentId": departmentId
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      // bool? status = result['status'];
      String message = result['message'];
      AppController.setmessage(message);
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      // bool? status = result['status'];
      String title = result['title'];
      String message = result['message'];

      Get.defaultDialog(
        title: 'Server Error',
        middleText: "$message",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          title: "Error",
          middleText: "$message",
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
            Get.offAll(const BottomNavHR(
              initialIndex: 0,
            ));
            // Get.back(); // Close the dialog
          },
        );
      }
    }
  }
}
