class GetUsersProjectModel {
  final int? projectId;
  final String? projectName;
  final String? code;
  final int? departmentId;

  GetUsersProjectModel({
    this.projectId,
    this.projectName,
    this.code,
    this.departmentId,
  });

  factory GetUsersProjectModel.fromJson(Map<String, dynamic> json) {
    return GetUsersProjectModel(
      projectId: json['projectId'],
      projectName: json['projectName'],
      code: json['code'],
      departmentId: json['departmentId'],
    );
  }
}
