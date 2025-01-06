class SignUpResponse {
  final bool success;
  final int? statusCode;
  final String message;
  final int? userOtp;

  SignUpResponse({
    required this.success,
    required this.message,
    this.statusCode,
    this.userOtp,
  });

  // Factory constructor to create an instance from a JSON object
  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'] ?? true, // Defaults to `true` for success case
      statusCode: json['statusCode'], // Nullable field
      message: json['message'],
      userOtp: json['userOtp'], // Nullable field
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'userOtp': userOtp,
    };
  }
}
