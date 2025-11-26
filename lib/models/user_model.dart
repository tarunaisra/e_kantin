class UserModel {
  final String userId; // NIM sebagai PK
  final String email;
  final String fullName;
  final String password;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      email: json['email'],
      fullName: json['full_name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'full_name': fullName,
      'password': password,
    };
  }
}
