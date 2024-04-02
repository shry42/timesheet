class ProjectsUserModel {
  final int? userId;
  final String? firstName;
  final String? lastName;

  ProjectsUserModel({
    this.userId,
    this.firstName,
    this.lastName,
  });

  factory ProjectsUserModel.fromJson(Map<String, dynamic> json) {
    return ProjectsUserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
