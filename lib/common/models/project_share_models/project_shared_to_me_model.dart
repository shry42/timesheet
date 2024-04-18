class ProjectSharedToMeModel {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final int? isVerified;
  final int? owner;
  final String? startDate;
  final String? endDate;
  final String? remark;
  final String? createdAt;
  final int? isActive;
  final int? departmentId;
  final String? firstName;
  final String? lastName;
  final int? sharedProjectId;
  final int? projectId;
  final int? sharedProjectStatus;
  final dynamic sharedProjectReason;
  final int? sharedProjectDepartment;

  ProjectSharedToMeModel({
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
    this.firstName,
    this.lastName,
    this.sharedProjectId,
    this.projectId,
    this.sharedProjectStatus,
    this.sharedProjectReason,
    this.sharedProjectDepartment,
  });

  factory ProjectSharedToMeModel.fromJson(Map<String, dynamic> json) {
    return ProjectSharedToMeModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      isVerified: json['isVerified'] as int?,
      owner: json['owner'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      remark: json['remark'] as String?,
      createdAt: json['createdAt'] as String?,
      isActive: json['isActive'] as int?,
      departmentId: json['departmentId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      sharedProjectId: json['sharedProjectId'] as int?,
      projectId: json['projectId'] as int?,
      sharedProjectStatus: json['sharedProjectStatus'] as int?,
      sharedProjectReason: json['sharedProjectReason'],
      sharedProjectDepartment: json['sharedProjectDepartment'] as int?,
    );
  }
}
