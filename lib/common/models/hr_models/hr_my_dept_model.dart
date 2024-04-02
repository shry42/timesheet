class MyDepartmentsModel {
  final int? id;
  final String? deptName;
  final int? isVerified;
  final int? isActive;

  MyDepartmentsModel({
    this.id,
    this.deptName,
    this.isVerified,
    this.isActive,
  });

  factory MyDepartmentsModel.fromJson(Map<String, dynamic> json) {
    return MyDepartmentsModel(
      id: json['id'],
      deptName: json['deptName'],
      isVerified: json['isVerified'],
      isActive: json['isActive'],
    );
  }
}
