import 'package:flutter/material.dart';

import '../../../api/api_controller.dart';
import '../DataModel/CourseEnrollDataModel.dart';

class CourseEnrollmentProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  CourseEnrollmentResponse? _courseEnrollmentResponse;

  CourseEnrollmentResponse? get response => _courseEnrollmentResponse;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchEnrollCourseResponse(String userId, String courseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _courseEnrollmentResponse =
          await _apiController.enrollInCourse(userId, courseId);
    } catch (e) {
      _courseEnrollmentResponse = CourseEnrollmentResponse(
        success: false,
        statusCode: 500,
        message: 'Enrollment failed. Please try again later.',
        error: e.toString(),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
