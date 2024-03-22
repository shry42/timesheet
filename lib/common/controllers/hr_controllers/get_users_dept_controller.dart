import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_user_dept_model.dart';
import 'package:timesheet/services/api_service.dart';

class UsersDepartmentController extends GetxController {
  static List<HRUsersDeptModel> usersDeptList = [];

  getAllDepartments(int id) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/department/userDepartment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "userId": id,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      usersDeptList = data.map((e) => HRUsersDeptModel.fromJson(e)).toList();
      return usersDeptList;
    }
  }
}
