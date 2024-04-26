import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class VerifyUsersController extends GetxController {
  Future verifyUser(
    int userId,
    String verify,
    String rejectReason,
  ) async {
    Map<String, dynamic> requestBody = {
      "userId": userId,
      "verify": verify,
    };

    if (rejectReason != null && rejectReason.isNotEmpty) {
      requestBody["rejectReason"] = rejectReason;
    }
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/auth/verifyUser'),
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
