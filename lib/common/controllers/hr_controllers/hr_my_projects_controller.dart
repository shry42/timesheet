import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_my_projects_model.dart';
import 'package:timesheet/services/api_service.dart';

class HRMyProjectsController extends GetxController {
  static List<HRMyProjectsModel> myProjectList = [];
  static List<HRMyProjectsModel> verifiedprojectList = [];

  Future myProjects() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/project/getMyProjects'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      myProjectList = data.map((e) => HRMyProjectsModel.fromJson(e)).toList();

      verifiedprojectList =
          myProjectList.where((element) => element.isVerified == 1).toList();
      return myProjectList;
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      String message = result['message'];
      Get.defaultDialog(
          title: 'Oops!',
          middleText: 'create Project first $message',
          onConfirm: () {
            Get.back();
          });
    }
  }
}
