import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';
import 'package:timesheet/utils/toast_notify.dart';

class ShareProjectToManagerController extends GetxController {
  Future shareProject(String projectId, sharedTo, departmentId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/project/shareProject'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "projectId": projectId,
        "shareTo": sharedTo,
        "departmentId": departmentId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      toast(message);
      Get.offAll(const BottomNavHR(
        initialIndex: 1,
      ));
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      toast(message);
      Get.offAll(const BottomNavHR(
        initialIndex: 1,
      ));
      // Get.back();
    }
  }
}
