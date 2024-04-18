import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';

class VerifyAllSharedProjectController extends GetxController {
  Future verifyAllSharedProject(int projectId, shareId, sharedTo, projectOwner,
      departmentId, String verify, projectCode, remark) async {
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/project/verifySharedProject'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: jsonEncode({
        //for 1 no reason,
        "projectId": projectId,
        "shareId": shareId,
        "verify": verify,
        // "reason": "Nice project",
        "projectCode": projectCode,
        "sharedTo": sharedTo,
        "projectOwner": projectOwner,
        "departmentId": departmentId,
        if (remark != null && remark.isNotEmpty) "reason": remark,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];
      AppController.setmessage(message);
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String title = result['title'];
      String message = result['message'];

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
            Get.offAll(LoginPage());
          },
        );
      }
    }
  }
}
