class MyTeamModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;

  MyTeamModel({this.id, this.firstName, this.lastName, this.email});

  factory MyTeamModel.fromJson(Map<String, dynamic> json) {
    return MyTeamModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
