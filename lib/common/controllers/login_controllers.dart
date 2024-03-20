import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/login_user_model.dart';
import 'package:timesheet/services/api_service.dart';

class loginController extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;
  String token = "";
  String role = "";
  UserDetails? user;

  Future<void> loginUser() async {
    // throw Exception();
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "email": email.value,
        "password": password.value,
      }),
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      String message = result['message'];
      AppController.setmessage(message);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      user = UserDetails.fromJson(result['userDetails']);
      AppController.setmessage(null);

      // // List userValue = result['userDeatils'];
      // // emailId.value = userValue[0]['emailId'];

      token = result['token'];
      int mainUid = user!.id;
      role = user!.role;
      AppController.setUserName('${user!.firstName} ${user!.lastName}');
      AppController.setEmail(user!.email);
      AppController.setMobile(user!.mobileNo);
      String roles = user!.role;
      AppController.setMainUid(mainUid);
      AppController.setRole(roles);
      print('******$token');
      AppController.setaccessToken(token);
    }
  }
}
