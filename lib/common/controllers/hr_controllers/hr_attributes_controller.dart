import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_attribute_model.dart';
import 'package:timesheet/services/api_service.dart';

class HRAttributesController extends GetxController {
  static List<AttributeModel> attributesList = [];

  Future attributes() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/attribute/getAllAttributes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      List<dynamic> data = result['data'];
      attributesList = data.map((e) => AttributeModel.fromJson(e)).toList();
      return attributesList;
    }
  }
}
