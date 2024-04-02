import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_projects_users_model.dart';
import 'package:timesheet/services/api_service.dart';

class ProjectsUsersController extends GetxController {
  static List<ProjectsUserModel> projectsUsersList = [];

  Future getProjectsUsers(int projectId) async {
    // List<MyTeamModel> myTeamListObj = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/project/projectUsers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "projectId": projectId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      projectsUsersList =
          data.map((e) => ProjectsUserModel.fromJson(e)).toList();

      return projectsUsersList;
    }
  }
}
