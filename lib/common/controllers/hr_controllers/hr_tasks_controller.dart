import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_tasks_model.dart';
import 'package:timesheet/services/api_service.dart';

class HRTasksController extends GetxController {
  static List<TaskModel> taskList = [];

  Future tasks() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/task/getAllTasks'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      taskList = data.map((e) => TaskModel.fromJson(e)).toList();
      return taskList;
    }
  }
}
