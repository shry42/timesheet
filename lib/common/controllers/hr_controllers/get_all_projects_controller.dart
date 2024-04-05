import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_all_projects_model.dart';
import 'package:timesheet/services/api_service.dart';

class AllProjectsController extends GetxController {
  static List<AllProjectsModel> allProjectList = [];

  Future allProjects() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getAllProjects'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      allProjectList = data.map((e) => AllProjectsModel.fromJson(e)).toList();
      return allProjectList;
    }
  }
}
