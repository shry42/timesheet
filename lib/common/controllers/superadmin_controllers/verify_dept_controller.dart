import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/bottom_navigations/hr_bottom_navigation.dart';
import 'package:timesheet/common/bottom_navigations/superadmin_navigation.dart';
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/services/api_service.dart';

class VerifyDepartmentController extends GetxController {
  // RxString remark = ''.obs;

  Future VerifyDepartment(
    int deptId,
    String verify,
    String remark,
  ) async {
//
    Map<String, dynamic> requestBody = {
      "departmentId": deptId,
      "verify": verify,
    };

    if (remark != null && remark.isNotEmpty) {
      requestBody["remark"] = remark;
    }
//
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/department/verifyDepartment'),
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
      Get.offAll(const BottomNavSuperAdmin(
        initialIndex: 3,
      ));
    }
  }
}
