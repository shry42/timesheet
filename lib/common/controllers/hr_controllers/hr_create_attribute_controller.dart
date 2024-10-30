import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/bottom_navigations/superadmin_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';

class CreateAttributeController extends GetxController {
  Future createAttribute(
    String attributeName,
    description,
  ) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/attribute/createAttribute'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "attributeName": attributeName,
        "description": description,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];

      Get.defaultDialog(
        title: "Success",
        middleText: message,
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          if (AppController.role == 'hrManager') {
            Get.offAll(const BottomNavHR(
              initialIndex: 4,
            ));
          } else if (AppController.role == 'superAdmin') {
            Get.offAll(const BottomNavSuperAdmin(
              initialIndex: 4,
            ));
          }
        },
      );
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
      }
    }
  }
}
