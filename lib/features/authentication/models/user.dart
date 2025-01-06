class AppUser {
  final int id;
  final String? username;
  final String? name;
  final String? email;
  final String? mobile;
  final String? photo;
  final String? userType;

  AppUser(
      {required this.id,
      this.username,
      this.name,
      this.email,
      this.mobile,
      this.photo,
      this.userType});
}
