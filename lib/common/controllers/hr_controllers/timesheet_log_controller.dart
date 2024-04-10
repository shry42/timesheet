import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/hr_attribute_model.dart';
import 'package:timesheet/services/api_service.dart';

class TimeSheetLogController extends GetxController {
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

  Future timesheetLog() async {
    String logDataString =
        '[{"projectId": ${projectId.value}, "taskId": ${taskId.value}, "attrId": ${projectId.value}, "taskDetails": {"2024-04-01": ${monHrs.value}, "2024-04-02": ${tueHrs.value}, "2024-04-03": ${wedHrs.value}, "2024-04-04": ${thurHrs.value}, "2024-04-05": ${friHrs.value}, "2024-04-06": ${satHrs.value}}, "description": ${description.value}, "departmentId": ${departmentId.value}}]';

    // Decode the logDataString into a list of maps
    List<Map<String, dynamic>> logDataList = json.decode(logDataString);

    // Add the new object to the list
    // logDataList.add({
    //   "projectId": 1,
    //   "taskId": 2,
    //   "attrId": 2,
    //   "taskDetails": {
    //     "2024-04-01": "4",
    //     "2024-04-02": "4",
    //     "2024-04-03": "4",
    //     "2024-04-04": "4",
    //     "2024-04-05": "4",
    //     "2024-04-06": "4"
    //   }
    // });

    // Encode the updated list back to a JSON string
    String updatedLogDataString = json.encode(logDataList);

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/insertLog'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: updatedLogDataString,
    );

    // Handle the response
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      String message = result['message'];
      Get.defaultDialog(
          title: 'Oops!',
          middleText: message,
          onConfirm: () {
            Get.back();
          });
    } else if (response.statusCode == 400) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      String message = result['message'];
      Get.defaultDialog(
          title: 'Oops!',
          middleText: message,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
