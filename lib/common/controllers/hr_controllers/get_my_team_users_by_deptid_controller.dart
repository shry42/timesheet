import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_my_team_users_by_id_model.dart';
import 'package:timesheet/services/api_service.dart';

class GetMyTeamUsersByDeptIdController extends GetxController {
  RxInt departmentId = 0.obs;

  static List<MyTeamUsersByDeptIdModel> myTeamUsersByDeptList = [];
  // static List verifiedDepartmentList = [];

  getAllDepartments(int deptId) async {
    // List<MyTeamUsersByDeptIdModel> allDepartmentList = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/auth/myTeamByDepartment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "departmentId": deptId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      myTeamUsersByDeptList =
          data.map((e) => MyTeamUsersByDeptIdModel.fromJson(e)).toList();

      return myTeamUsersByDeptList;
    }
  }
}
