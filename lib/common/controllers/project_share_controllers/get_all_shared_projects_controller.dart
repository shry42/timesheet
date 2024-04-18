import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/project_share_models/all_shared_project_model.dart';
import 'package:timesheet/services/api_service.dart';

class AllSharedProjectsController extends GetxController {
  static List<AllSharedProjectModel> allSharedProjectlist = [];

  Future getAllSharedProjects() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getAllSharedProjects'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      allSharedProjectlist =
          data.map((e) => AllSharedProjectModel.fromJson(e)).toList();
      return allSharedProjectlist;
    }
  }
}
