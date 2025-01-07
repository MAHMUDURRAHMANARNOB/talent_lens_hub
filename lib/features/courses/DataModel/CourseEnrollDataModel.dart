class CourseEnrollmentResponse {
  final bool? success;
  final int? statusCode;
  final String? message;
  final String? error;

  CourseEnrollmentResponse({
    this.success,
    this.statusCode,
    this.message,
    this.error,
  });

  factory CourseEnrollmentResponse.fromJson(Map<String, dynamic> json) {
    return CourseEnrollmentResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'error': error,
    };
  }
}
