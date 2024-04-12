class TimesheetEntry {
  String? description;

  int? logId;
  int? projectId;
  Map<String, String>? taskDetails;
  int? taskId;

  TimesheetEntry({
    this.description,
    this.logId,
    this.projectId,
    this.taskDetails,
    this.taskId,
  });

  // Add any other necessary methods or properties here
}
