class HRMyProjectsModel {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final int? isVerified;
  final int? owner;
  final String? startDate;
  final String? endDate;
  final String? remark;
  final DateTime? createdAt;
  final int? isActive;
  final int? departmentId;

  HRMyProjectsModel({
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
  });

  factory HRMyProjectsModel.fromJson(Map<String, dynamic> json) {
    return HRMyProjectsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      isVerified: json['isVerified'],
      owner: json['owner'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      remark: json['remark'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      isActive: json['isActive'],
      departmentId: json['departmentId'],
    );
  }
}
