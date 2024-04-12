import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';
import 'package:timesheet/services/api_service.dart';

class GetTimesheetLogController extends GetxController {
  RxList<TimesheetEntry> timesheetEntries = <TimesheetEntry>[].obs;

  static List<dynamic> taskDetailsList = [];

  Future<List<TimesheetEntry>> getTimesheetLogData(String date) async {
    List<TimesheetEntry> timesheetDataList = [];
    taskDetailsList = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/getTimesheetLog'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      // body: json.encode({"date": date.toIso8601String().substring(0, 10)}),
      body: json.encode({"date": date.substring(0, 10)}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> timesheets = json.decode(result['timesheet']);

      timesheetDataList =
          timesheets.map((entry) => TimesheetEntry.fromJson(entry)).toList();
    }

    for (var entry in timesheetDataList) {
      taskDetailsList.add(entry.taskDetails);
    }

    // for (var entry in timesheetDataList) {
    //   for (var detail in entry.taskDetails!.entries) {
    //     taskDetailsList.add(TaskDetailItem(detail.key, detail.value));
    //   }
    // }

    return timesheetDataList;
  }
}

// class TaskDetailItem {
//   final String date;
//   final String value;

//   TaskDetailItem(this.date, this.value);
// }
