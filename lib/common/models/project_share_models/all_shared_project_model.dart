import 'dart:convert';

class AllSharedProjectModel {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final int? isVerified;
  final int? owner;
  final String? startDate;
  final String? endDate;
  final dynamic? remark;
  final String? createdAt;
  final int? isActive;
  final int? departmentId;
  final String? projectOwner;
  final int? sharedTo;
  final String? sharedToName;
  final String? deptName;
  final int? sharedProjectId;
  final int? projectId;
  final int? sharedProjectStatus;
  final dynamic? sharedProjectReason;
  final int? sharedProjectDepartment;

  AllSharedProjectModel({
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
    this.projectOwner,
    this.sharedTo,
    this.sharedToName,
    this.deptName,
    this.sharedProjectId,
    this.projectId,
    this.sharedProjectStatus,
    this.sharedProjectReason,
    this.sharedProjectDepartment,
  });

  factory AllSharedProjectModel.fromJson(Map<String, dynamic> json) {
    return AllSharedProjectModel(
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
      projectOwner: json['projectOwner'],
      sharedTo: json['sharedTo'],
      sharedToName: json['sharedToName'],
      deptName: json['deptName'],
      sharedProjectId: json['sharedProjectId'],
      projectId: json['projectId'],
      sharedProjectStatus: json['sharedProjectStatus'],
      sharedProjectReason: json['sharedProjectReason'],
      sharedProjectDepartment: json['sharedProjectDepartment'],
    );
  }
}
