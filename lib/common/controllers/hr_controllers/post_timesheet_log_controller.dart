import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';
import 'package:timesheet/common/models/hr_models/hr_attribute_model.dart';
import 'package:timesheet/services/api_service.dart';

class PostTimeSheetLogController extends GetxController {
  RxString date = '0'.obs;

  RxString monHrs = '0'.obs;
  RxString tueHrs = '0'.obs;
  RxString wedHrs = '0'.obs;
  RxString thurHrs = '0'.obs;
  RxString friHrs = '0'.obs;
  RxString satHrs = '0'.obs;

  RxInt projectId = 0.obs;
  RxInt taskId = 0.obs;
  RxInt attrId = 0.obs;
  RxInt departmentId = 0.obs;
  RxString description = ''.obs;

  static List<AttributeModel> attributesList = [];

  Future<void> posttimesheetLog(
      List<TimesheetEntry> allLogDataList, String date) async {
    List<Map<String, dynamic>> logDataList =
        allLogDataList.map((entry) => entry.toJson()).toList();
    String updatedLogDataString = json.encode(logDataList);

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/insertLog'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "date": date,
        "logData": updatedLogDataString,
      }),
    );

    // Handle the response
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      String message = result['message'];
      Get.defaultDialog(
          title: 'Success!',
          middleText: message,
          onConfirm: () {
            Get.back();
          });
    } else if (response.statusCode == 400) {
      Map<String, dynamic> result = json.decode(response.body);
      String title = result['title'];
      String message = result['message'];
      Get.defaultDialog(
          title: title,
          middleText: message,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
