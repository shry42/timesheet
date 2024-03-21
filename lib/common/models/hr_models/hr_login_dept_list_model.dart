import 'dart:convert';

class HRLoginDeptDetListModel {
  final String? name;
  final int? id;
  final int? verified;
  final int? active;

  HRLoginDeptDetListModel({
    required this.name,
    required this.id,
    required this.verified,
    required this.active,
  });

  factory HRLoginDeptDetListModel.fromJson(Map<String, dynamic> json) {
    return HRLoginDeptDetListModel(
      name: json['name'],
      id: json['id'],
      verified: json['verified'],
      active: json['active'],
    );
  }
}
