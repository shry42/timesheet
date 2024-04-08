class TaskByDeptIdModel {
  int? id;
  int? projectId;
  String? task;
  int? departmentId;
  int? isVerified;
  int? createdBy;
  DateTime? createdAt;
  int? isActive;
  String? remark;
  String? description;

  TaskByDeptIdModel({
    this.id,
    this.projectId,
    this.task,
    this.departmentId,
    this.isVerified,
    this.createdBy,
    this.createdAt,
    this.isActive,
    this.remark,
    this.description,
  });

  factory TaskByDeptIdModel.fromJson(Map<String, dynamic> json) =>
      TaskByDeptIdModel(
        id: json['id'] as int?,
        projectId: json['projectId'] as int?,
        task: json['task'] as String?,
        departmentId: json['departmentId'] as int?,
        isVerified: json['isVerified'] as int?,
        createdBy: json['createdBy'] as int?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        isActive: json['isActive'] as int?,
        remark: json['remark'] as String?,
        description: json['description'] as String?,
      );
}
