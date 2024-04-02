import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_get_myteam.dart';
import 'package:timesheet/services/api_service.dart';

class MyTeamListController extends GetxController {
  static List<MyTeamModel> myTeamList = [];

  getMyTeamList() async {
    List<MyTeamModel> myTeamListObj = [];

    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/auth/myTeam'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      myTeamListObj = data.map((e) => MyTeamModel.fromJson(e)).toList();

      // Filter users where isManager is 1
      myTeamList = myTeamListObj
          .where((user) => user.id != AppController.mainUid)
          .toList();

      return myTeamList;
    }
  }
}
