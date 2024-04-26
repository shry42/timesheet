import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';
import 'package:timesheet/utils/toast_notify.dart';

class PasswordResetcontroller extends GetxController {
  RxString newPassword = "".obs;
  RxString confirmPssword = "".obs;
  // RxInt id = 0.obs;

  Future<void> changePassword() async {
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/auth/updatePassword'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "id": AppController.mainUid,
        "newPassword": newPassword.value,
        "confirmPassword": confirmPssword.value,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      // updateStatus = result['message'];
      bool? status = result['status'];

      if (status == true) {
        toast("Pssword changed Successfully");
      } else {
        toast("Unable to change password");
      }
    } else {
      toast("Something went wrong");
    }
  }
}
