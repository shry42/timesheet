import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_progress_model.dart';
import 'package:timesheet/services/api_service.dart';

class GetUsersTimesheetController extends GetxController {
  RxList<TimesheetEntry> timesheetEntries = <TimesheetEntry>[].obs;

  static List<TimesheetModel> taskDetailsList = [];
  List<InProcessTimesheet> inProcessTimesheet = [];

  // use below to acces the weekly hours data takslist
  static List<dynamic> inProcessTaskList = [];

  //  use below fields to access the main data oustide
  List<dynamic> inProcessDataList = [];

  Future getUsersTimesheetData(String date, userId) async {
    // List<TimesheetEntry> timesheetDataList = [];
    taskDetailsList = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/getUserTimesheet'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      // body: json.encode({"date": date.toIso8601String().substring(0, 10)}),
      body: json.encode({
        "date": date.substring(0, 10),
        "userId": userId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> dataInprocess = result['data'] ?? [];

      if (dataInprocess.isNotEmpty) {
        inProcessTimesheet = [InProcessTimesheet.fromJson(dataInprocess[0])];

        List<dynamic> inProcessTimesheetArray = inProcessTimesheet
            .map((inProcess) => inProcess.timesheetArray)
            .expand((array) => array)
            .toList();

        for (var entry in inProcessTimesheetArray) {
          inProcessTaskList.add(entry.taskDetails);
        }
        inProcessDataList = inProcessTimesheetArray;
      } else {
        inProcessDataList = [];
      }

      //

      return inProcessDataList;
    } else {
      return inProcessDataList = [];
    }
  }
}
