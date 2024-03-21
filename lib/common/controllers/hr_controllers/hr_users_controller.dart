import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_users_model.dart';
import 'package:timesheet/services/api_service.dart';

class HRUsersController extends GetxController {
  static List<HRAllUsersListModel> managersList = [];

  getHRUsersList() async {
    List<HRAllUsersListModel> hrUserListObj = [];

    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/auth/allUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      hrUserListObj = data.map((e) => HRAllUsersListModel.fromJson(e)).toList();

      // Populate reportingManagerWithName field
      for (var user in hrUserListObj) {
        if (user.reportingManager != null) {
          HRAllUsersListModel? reportingManager = hrUserListObj
              .firstWhere((manager) => manager.id == user.reportingManager);
          user.reportingManagerWithName = reportingManager != null
              ? '${reportingManager.firstName} ${reportingManager.lastName}'
              : '';
        } else {
          user.reportingManagerWithName = '';
        }
      }

      // Filter users where isManager is 1
      managersList =
          hrUserListObj.where((user) => user.isManager == 1).toList();

      return hrUserListObj;
    }
  }
}
