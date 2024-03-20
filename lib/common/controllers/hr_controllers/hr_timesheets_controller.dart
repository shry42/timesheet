import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/bottom_navigation_hr.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class CreateRoomController extends GetxController {
  Future createRoom(
      String name, floor, roomDetails, meetingType, int seatingCapacity) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "name": name,
        "floor": floor,
        "seatingCapacity": seatingCapacity,
        "roomDetails": roomDetails,
        "meetingType": meetingType,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];

      if (status == true) {
        Get.defaultDialog(
          title: "Success",
          middleText: "$message",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            // Get.back(); // Close the dialog
            Get.offAll(const BottomNavHR(
              initialIndex: 2,
            ));
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
              Get.offAll(const BottomNavHR());
              // Get.back(); // Close the dialog
            },
          );
        }
      }
    }
  }
}
