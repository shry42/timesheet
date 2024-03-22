class HRUsersDeptModel {
  final int? id;
  final String? deptName;
  final int? isVerified;
  final int? isActive;

  HRUsersDeptModel({
    this.id,
    this.deptName,
    this.isVerified,
    this.isActive,
  });

  factory HRUsersDeptModel.fromJson(Map<String, dynamic> json) {
    return HRUsersDeptModel(
      id: json['id'],
      deptName: json['deptName'],
      isVerified: json['isVerified'],
      isActive: json['isActive'],
    );
  }
}
