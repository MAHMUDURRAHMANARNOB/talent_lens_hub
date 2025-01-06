class LoginResponse {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final String? photo;
  final String? userType;
  final String? companyId;
  final double? profileId;
  final double? partnerId;
  final String? lastLogin;
  final String? is_register;
  final String? isactive;
  final int? otp;

  LoginResponse({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.photo,
    this.userType,
    this.companyId,
    this.profileId,
    this.partnerId,
    this.lastLogin,
    this.is_register,
    this.isactive,
    this.otp,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      userType: json['userType'],
      companyId: json['companyId'],
      profileId: json['profileId'],
      partnerId: json['partnerId'],
      lastLogin: json['lastLogin'],
      is_register: json['is_register'],
      isactive: json['isactive'],
      otp: json['otp'],
    );
  }
}
