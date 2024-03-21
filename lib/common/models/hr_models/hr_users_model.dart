class HRAllUsersListModel {
  final String firstName;
  final String lastName;
  final int id;
  final String email;
  final String role;
  final String createdAt;
  final int isActive;
  final int createdBy;
  final String mobileNo;
  final int isVerified;
  final int isManager;
  final String? rejectReason;
  final String? deleteReason;
  final int? reportingManager;

  String? reportingManagerWithName = ''; // Add this field

  // Constructor and other methods

  HRAllUsersListModel({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.isActive,
    required this.createdBy,
    required this.mobileNo,
    required this.isVerified,
    required this.isManager,
    this.rejectReason,
    this.deleteReason,
    this.reportingManager,
    this.reportingManagerWithName, // Add this field
  });

  factory HRAllUsersListModel.fromJson(Map<String, dynamic> json) {
    return HRAllUsersListModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      mobileNo: json['mobileNo'],
      isVerified: json['isVerified'],
      isManager: json['isManager'],
      rejectReason: json['rejectReason'],
      deleteReason: json['deleteReason'],
      reportingManager:
          json['reportingManager'], // Initialize with an empty string
      reportingManagerWithName: json['reportingManagerWithName'],
    );
  }
}
