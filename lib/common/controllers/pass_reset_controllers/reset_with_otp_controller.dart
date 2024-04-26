import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';
import 'package:timesheet/utils/toast_notify.dart';

class PasswordResetWithOtpController extends GetxController {
  Future resetWithOtp(String empId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/auth/forgotPassword'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "employeeId": empId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      toast(message);
      // Get.back();
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Oops!',
          middleText: ' $message',
          onConfirm: () {
            Get.offAll(LoginPage());
          });
    }
  }
}
