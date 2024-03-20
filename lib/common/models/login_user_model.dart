import 'dart:convert';

class UserDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String role;

  UserDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.role,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['role'] = this.role;
    return data;
  }
}
