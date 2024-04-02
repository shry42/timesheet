import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_my_dept_model.dart';
import 'package:timesheet/services/api_service.dart';

class MyDepartmentsController extends GetxController {
  static List<MyDepartmentsModel> myDeptList = [];

  getMyDepartments() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/department/myDepartment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      myDeptList = data.map((e) => MyDepartmentsModel.fromJson(e)).toList();
      return myDeptList;
    }
  }
}
