class Timesheet {
  List<TimesheetEntry>? timesheets;

  Timesheet({this.timesheets});

  factory Timesheet.fromJson(List<dynamic> json) {
    List<TimesheetEntry> timesheets = [];
    timesheets = json.map((entry) => TimesheetEntry.fromJson(entry)).toList();
    return Timesheet(timesheets: timesheets);
  }
}

class TimesheetEntry {
  int? projectId;
  int? taskId;
  int? attrId;
  Map<String, String>? taskDetails;
  String? description;
  int? departmentId;
  int? logId;

  TimesheetEntry({
    this.projectId,
    this.taskId,
    this.attrId,
    this.taskDetails,
    this.description,
    this.departmentId,
    this.logId,
  });

  factory TimesheetEntry.fromJson(Map<String, dynamic> json) {
    return TimesheetEntry(
      projectId: json['projectId'],
      taskId: json['taskId'],
      attrId: json['attrId'],
      taskDetails: json['taskDetails'] != null
          ? Map<String, String>.from(json['taskDetails'])
          : null,
      description: json['description'],
      departmentId: json['departmentId'],
      logId: json['logId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "projectId": projectId,
      "taskId": taskId,
      "attrId": attrId,
      "taskDetails":
          taskDetails != null ? Map<String, String>.from(taskDetails!) : null,
      "description": description,
      "departmentId": departmentId,
      "logId": logId,
    };
  }
}
