class MyTeamUsersByDeptIdModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? isManager;

  MyTeamUsersByDeptIdModel(
      {this.id, this.firstName, this.lastName, this.email, this.isManager});

  factory MyTeamUsersByDeptIdModel.fromJson(Map<String, dynamic> json) {
    return MyTeamUsersByDeptIdModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isManager: json['isManager'],
    );
  }
}
