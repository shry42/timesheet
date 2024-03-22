import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_all_department_model.dart';
import 'package:timesheet/common/models/hr_models/hr_users_model.dart';
import 'package:timesheet/services/api_service.dart';

class AllDepartmentList extends GetxController {
  static List<HRAllUsersListModel> managersList = [];
  static List verifiedDepartmentList = [];

  getAllDepartments() async {
    List<DepartmentModel> allDepartmentList = [];

    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/department/getAllDepartments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      allDepartmentList = data.map((e) => DepartmentModel.fromJson(e)).toList();

      // Filter users where isVerified == 1
      verifiedDepartmentList =
          allDepartmentList.where((e) => e.isVerified == 1).toList();

      return allDepartmentList;
    }
  }
}
