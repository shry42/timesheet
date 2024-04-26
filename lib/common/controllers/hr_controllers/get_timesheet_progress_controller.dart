import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:timesheet/common/controllers/app_controller.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_log_model.dart';
import 'package:timesheet/common/models/hr_models/get_timesheet_progress_model.dart';
import 'package:timesheet/services/api_service.dart';

class GetTimesheetStatusController extends GetxController {
  RxList<TimesheetEntry> timesheetEntries = <TimesheetEntry>[].obs;

  static List<TimesheetModel> taskDetailsList = [];
  List<InProcessTimesheet> inProcessTimesheet = [];
  List<RejectedTimesheet> rejectedTimesheet = [];
  List<ApprovedTimesheet> approvedTimesheet = [];

  // use below to acces the weekly hours data takslist
  static List<dynamic> inProcessTaskList = [];
  static List<dynamic> rejectedTaskList = [];
  static List<dynamic> approvedTaskList = [];
  //  use below fields to access the main data oustide
  List<dynamic> inProcessDataList = [];
  List<dynamic> rejectedDataList = [];
  List<dynamic> approvedDataList = [];

  //

  Future getTimesheetStatusData(String date) async {
    List<TimesheetEntry> timesheetDataList = [];
    taskDetailsList = [];

    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/timesheet/getTimesheet'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      // body: json.encode({"date": date.toIso8601String().substring(0, 10)}),
      body: json.encode({"date": date.substring(0, 10)}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> dataInprocess = result['inProcessTimesheet'] ?? [];
      List<dynamic> dataRejected = result['rejectedTimesheet'] ?? [];
      List<dynamic> dataApproved = result['approvedTimesheet'] ?? [];

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
      if (dataRejected.isNotEmpty) {
        rejectedTimesheet = [RejectedTimesheet.fromJson(dataRejected[0])];
        List<dynamic> rejectedTimesheetArray = rejectedTimesheet
            .map((rejected) => rejected.timesheetArray)
            .expand((array) => array)
            .toList();

        for (var entry in rejectedTimesheetArray) {
          rejectedTaskList.add(entry.taskDetails);
        }
        rejectedDataList = rejectedTimesheetArray;
      } else {
        rejectedDataList = [];
      }

      //

      if (dataApproved.isNotEmpty) {
        approvedTimesheet = [ApprovedTimesheet.fromJson(dataApproved[0])];
        List<dynamic> approvedTimesheetArray = approvedTimesheet
            .map((approved) => approved.timesheetArray)
            .expand((array) => array)
            .toList();

        for (var entry in approvedTimesheetArray) {
          approvedTaskList.add(entry.taskDetails);
        }
        approvedDataList = approvedTimesheetArray;
      } else {
        approvedDataList = [];
      }
      // return inProcessTimesheetArray;
      return inProcessDataList;
    } else {
      rejectedDataList = [];
      approvedDataList = [];
      return inProcessDataList = [];
    }
  }
}
