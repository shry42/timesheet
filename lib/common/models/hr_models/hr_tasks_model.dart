class TaskModel {
  final int? id;
  final int? projectId;
  final String? task;
  final int? departmentId;
  final int? isVerified;
  final int? createdBy;
  final DateTime? createdAt;
  final int? isActive;
  final String? remark;
  final String? description;

  TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      projectId: json['projectId'],
      task: json['task'],
      departmentId: json['departmentId'],
      isVerified: json['isVerified'],
      createdBy: json['createdBy'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      isActive: json['isActive'],
      remark: json['remark'],
      description: json['description'],
    );
  }
}
