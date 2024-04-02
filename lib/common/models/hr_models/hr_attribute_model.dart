class AttributeModel {
  final int? id;
  final String? name;
  final String? description;
  final int? createdBy;
  final DateTime? createdAt;
  final int? isActive;

  AttributeModel({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.createdAt,
    this.isActive,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdBy: json['createdBy'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      isActive: json['isActive'],
    );
  }
}
