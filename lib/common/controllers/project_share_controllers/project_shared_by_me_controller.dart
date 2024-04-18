import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/project_share_models/project_shared_by_me.dart';
import 'package:timesheet/services/api_service.dart';

class ProjectSharedByMeController extends GetxController {
  static List<ProjectSharedByMeModel> projectSharedByMeList = [];

  Future getProjectSharedByMe() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getSharedProjectsByMe'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      projectSharedByMeList =
          data.map((e) => ProjectSharedByMeModel.fromJson(e)).toList();
      return projectSharedByMeList;
    }
  }
}
