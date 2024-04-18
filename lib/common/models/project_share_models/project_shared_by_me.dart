class ProjectSharedByMeModel {
  int? id;
  String? name;
  String? description;
  String? code;
  int? isVerified;
  int? owner;
  String? startDate;
  String? endDate;
  dynamic? remark;
  String? createdAt;
  int? isActive;
  int? departmentId;
  int? sharedProjectId;
  int? sharedProjectStatus;
  String? firstName;
  String? lastName;
  String? deptName;
  int? projectId;
  dynamic? sharedProjectReason;
  int? sharedProjectDepartment;

  ProjectSharedByMeModel({
    this.id,
    this.name,
    this.description,
    this.code,
    this.isVerified,
    this.owner,
    this.startDate,
    this.endDate,
    this.remark,
    this.createdAt,
    this.isActive,
    this.departmentId,
    this.sharedProjectId,
    this.sharedProjectStatus,
    this.firstName,
    this.lastName,
    this.deptName,
    this.projectId,
    this.sharedProjectReason,
    this.sharedProjectDepartment,
  });

  factory ProjectSharedByMeModel.fromJson(Map<String, dynamic> json) {
    return ProjectSharedByMeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      isVerified: json['isVerified'],
      owner: json['owner'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      remark: json['remark'],
      createdAt: json['createdAt'],
      isActive: json['isActive'],
      departmentId: json['departmentId'],
      sharedProjectId: json['sharedProjectId'],
      sharedProjectStatus: json['sharedProjectStatus'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      deptName: json['deptName'],
      projectId: json['projectId'],
      sharedProjectReason: json['sharedProjectReason'],
      sharedProjectDepartment: json['sharedProjectDepartment'],
    );
  }
}
