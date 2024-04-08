import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_task_by_depid_model.dart';
import 'package:timesheet/services/api_service.dart';

class GetTaskByDeptIdController extends GetxController {
  RxInt TaskId = 0.obs;

  static List<TaskByDeptIdModel> taskListsByDepId = [];

  static getTasksByDepId(int deptId) async {
    // List<TaskByDeptIdModel> taskListsByDepId = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/task/getTaskByDepartment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "departmentId": deptId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      taskListsByDepId =
          data.map((e) => TaskByDeptIdModel.fromJson(e)).toList();

      return taskListsByDepId;
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      Get.defaultDialog(
          title: 'Oops!',
          middleText: '$message, create task first',
          onConfirm: () {
            Get.back();
          });
    }
  }
}
