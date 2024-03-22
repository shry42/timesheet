class DepartmentModel {
  final int id;
  final String? name;
  final int? isVerified;
  final int? createdBy;
  final String? createdAt;
  final int? isActive;
  final String? remark;

  DepartmentModel({
    required this.id,
    this.name,
    this.isVerified,
    this.createdBy,
    this.createdAt,
    this.isActive,
    this.remark,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      name: json['name'],
      isVerified: json['isVerified'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      isActive: json['isActive'],
      remark: json['remark'],
    );
  }
}
