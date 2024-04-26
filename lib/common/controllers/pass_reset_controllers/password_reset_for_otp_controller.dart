import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/screens/login_screen.dart';
import 'package:timesheet/services/api_service.dart';

class PasswordResetForOtpController extends GetxController {
  Future resetPass(String empId, newPass, conPass, otp) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/auth/userResetPasswordRequest'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "employeeId": empId,
        "newPassword": newPass,
        "confirmPassword": conPass,
        "otp": otp
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Success!',
          middleText: '$message',
          onConfirm: () {
            Get.offAll(LoginPage());
          });
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Oops!',
          middleText: '$message',
          onConfirm: () {
            Get.back();
          });
    }
  }
}
