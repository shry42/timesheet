import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class VerifyTaskController extends GetxController {
  // RxString remark = ''.obs;

  Future verifyTask(
    int taskId,
    String verify,
    String remark,
  ) async {
//
    Map<String, dynamic> requestBody = {
      "taskId": taskId,
      "verify": verify,
    };

    if (remark != null && remark.isNotEmpty) {
      requestBody["remark"] = remark;
    }
//
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/task/verifyTask'),
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
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      // AppController.setmessage(null);
      String message = result['message'];
      AppController.setmessage(message);
    }
  }
}
