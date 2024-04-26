import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class VerifyUsersTimesheetController extends GetxController {
  // RxString remark = ''.obs;

  Future verifyTimesheet(
    int userId,
    String status,
    String date,
    String reason,
  ) async {
//
    Map<String, dynamic> requestBody = {
      "status": status,
      "date": date,
      "userId": userId
    };

    if (reason != null && reason.isNotEmpty) {
      requestBody["reason"] = reason;
    }
//
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/updateStatus'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      String message = result['message'];
      AppController.setmessage(message);
      Get.back();
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      // AppController.setmessage(null);
      String message = result['message'];
      AppController.setmessage(message);
      Get.back();
    }
  }
}
