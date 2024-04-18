class TimesheetModel {
  bool status;
  int resultCount;
  List<InProcessTimesheet> inProcessTimesheet;
  List<RejectedTimesheet> rejectedTimesheet;
  List<ApprovedTimesheet> approvedTimesheet;

  TimesheetModel({
    required this.status,
    required this.resultCount,
    required this.inProcessTimesheet,
    required this.rejectedTimesheet,
    required this.approvedTimesheet,
  });

  factory TimesheetModel.fromJson(Map<String, dynamic> json) {
    return TimesheetModel(
      status: json['status'],
      resultCount: json['resultCount'],
      inProcessTimesheet: (json['inProcessTimesheet'] as List)
          .map((e) => InProcessTimesheet.fromJson(e))
          .toList(),
      rejectedTimesheet: (json['rejectedTimesheet'] as List)
          .map((e) => RejectedTimesheet.fromJson(e))
          .toList(),
      approvedTimesheet: (json['approvedTimesheet'] as List)
          .map((e) => ApprovedTimesheet.fromJson(e))
          .toList(),
    );
  }
}

class InProcessTimesheet {
  int id;
  int userId;
  String forDate;
  int projectId;
  int taskId;
  int attributeId;
  String hours;
  String status;
  int createdBy;
  String createdAt;
  String description;
  String? reason;
  String startDate;
  int departmentId;
  String submitExpiryDate;
  String reviewExpiryDate;
  int isActive;
  List<TimesheetArray> timesheetArray;

  InProcessTimesheet({
    required this.id,
    required this.userId,
    required this.forDate,
    required this.projectId,
    required this.taskId,
    required this.attributeId,
    required this.hours,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.description,
    required this.reason,
    required this.startDate,
    required this.departmentId,
    required this.submitExpiryDate,
    required this.reviewExpiryDate,
    required this.isActive,
    required this.timesheetArray,
  });

  factory InProcessTimesheet.fromJson(Map<String, dynamic> json) {
    return InProcessTimesheet(
      id: json['id'],
      userId: json['userId'],
      forDate: json['forDate'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      attributeId: json['attributeId'],
      hours: json['hours'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      description: json['description'],
      reason: json['reason'],
      startDate: json['startDate'],
      departmentId: json['departmentId'],
      submitExpiryDate: json['submitExpiryDate'],
      reviewExpiryDate: json['reviewExpiryDate'],
      isActive: json['isActive'],
      timesheetArray: (json['timesheetArray'] as List)
          .map((e) => TimesheetArray.fromJson(e))
          .toList(),
    );
  }
}

class RejectedTimesheet {
  int id;
  int userId;
  String forDate;
  int projectId;
  int taskId;
  int attributeId;
  String hours;
  String status;
  int createdBy;
  String createdAt;
  String description;
  String? reason;
  String startDate;
  int departmentId;
  String submitExpiryDate;
  String reviewExpiryDate;
  int isActive;
  List<TimesheetArray> timesheetArray;

  RejectedTimesheet({
    required this.id,
    required this.userId,
    required this.forDate,
    required this.projectId,
    required this.taskId,
    required this.attributeId,
    required this.hours,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.description,
    required this.reason,
    required this.startDate,
    required this.departmentId,
    required this.submitExpiryDate,
    required this.reviewExpiryDate,
    required this.isActive,
    required this.timesheetArray,
  });

  factory RejectedTimesheet.fromJson(Map<String, dynamic> json) {
    return RejectedTimesheet(
      id: json['id'],
      userId: json['userId'],
      forDate: json['forDate'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      attributeId: json['attributeId'],
      hours: json['hours'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      description: json['description'],
      reason: json['reason'],
      startDate: json['startDate'],
      departmentId: json['departmentId'],
      submitExpiryDate: json['submitExpiryDate'],
      reviewExpiryDate: json['reviewExpiryDate'],
      isActive: json['isActive'],
      timesheetArray: (json['timesheetArray'] as List)
          .map((e) => TimesheetArray.fromJson(e))
          .toList(),
    );
  }
}

class ApprovedTimesheet {
  int id;
  int userId;
  String forDate;
  int projectId;
  int taskId;
  int attributeId;
  String hours;
  String status;
  int createdBy;
  String createdAt;
  String description;
  String? reason;
  String startDate;
  int departmentId;
  String submitExpiryDate;
  String reviewExpiryDate;
  int isActive;
  List<TimesheetArray> timesheetArray;

  ApprovedTimesheet({
    required this.id,
    required this.userId,
    required this.forDate,
    required this.projectId,
    required this.taskId,
    required this.attributeId,
    required this.hours,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.description,
    required this.reason,
    required this.startDate,
    required this.departmentId,
    required this.submitExpiryDate,
    required this.reviewExpiryDate,
    required this.isActive,
    required this.timesheetArray,
  });

  factory ApprovedTimesheet.fromJson(Map<String, dynamic> json) {
    return ApprovedTimesheet(
      id: json['id'],
      userId: json['userId'],
      forDate: json['forDate'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      attributeId: json['attributeId'],
      hours: json['hours'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      description: json['description'],
      reason: json['reason'],
      startDate: json['startDate'],
      departmentId: json['departmentId'],
      submitExpiryDate: json['submitExpiryDate'],
      reviewExpiryDate: json['reviewExpiryDate'],
      isActive: json['isActive'],
      timesheetArray: (json['timesheetArray'] as List)
          .map((e) => TimesheetArray.fromJson(e))
          .toList(),
    );
  }
}

class TimesheetArray {
  int projectId;
  int taskId;
  int attrId;
  Map<String, String> taskDetails;
  String description;
  int departmentId;
  int logId;

  TimesheetArray({
    required this.projectId,
    required this.taskId,
    required this.attrId,
    required this.taskDetails,
    required this.description,
    required this.departmentId,
    required this.logId,
  });

  factory TimesheetArray.fromJson(Map<String, dynamic> json) {
    return TimesheetArray(
      projectId: json['projectId'],
      taskId: json['taskId'],
      attrId: json['attrId'],
      taskDetails: Map<String, String>.from(json['taskDetails']),
      description: json['description'],
      departmentId: json['departmentId'],
      logId: json['logId'],
    );
  }
}
