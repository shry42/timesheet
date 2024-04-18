import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/project_share_models/project_shared_to_me_model.dart';
import 'package:timesheet/services/api_service.dart';

class ProjectSharedToMeController extends GetxController {
  static List<ProjectSharedToMeModel> projectSharedToMeList = [];

  Future getProjectSharedToMe() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getSharedProjectsToMe'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      projectSharedToMeList =
          data.map((e) => ProjectSharedToMeModel.fromJson(e)).toList();
      return projectSharedToMeList;
    }
  }
}
