import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_users_project_model.dart';
import 'package:timesheet/services/api_service.dart';

class getUsersProjectsController extends GetxController {
  static List<GetUsersProjectModel> usersProjectList = [];

  Future getUsersProjects() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getAssignedProjects'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      usersProjectList =
          data.map((e) => GetUsersProjectModel.fromJson(e)).toList();
      return usersProjectList;
    }
  }
}
