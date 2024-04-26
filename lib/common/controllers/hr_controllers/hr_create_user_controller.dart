import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';

class CreateUserController extends GetxController {
  Future createUser(
    String firstName,
    lastName,
    email,
    employeeId,
    password,
    confirmPass,
    mobileNo,
    int reportingManagerId,
    int isManager,
    List<dynamic> departments,
  ) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/auth/registerUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "employeeId": employeeId,
        "password": password,
        "confirmPassword": confirmPass,
        "mobileNo": mobileNo,
        "isManager": isManager,
        "reportingManager": reportingManagerId,
        "department": departments,
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
              initialIndex: 0,
            ));
          },
        );
      }
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      // bool? status = result['status'];
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
