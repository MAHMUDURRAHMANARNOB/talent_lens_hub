import 'package:flutter/material.dart';
import 'package:talent_lens_hub/api/api_controller.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CheckCourseEnrollmentDataModel.dart';

class CheckCourseEnrollmentProvider with ChangeNotifier {
  CheckEnrollmentDataModel? _courseData;
  bool _isLoading = false;

  CheckEnrollmentDataModel? get courseData => _courseData;

  bool get isLoading => _isLoading;

  final ApiController _apiController = ApiController();

  Future<CheckEnrollmentDataModel?> fetchEnrollCourse(
      int courseId, int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      return _courseData =
          await _apiController.checkIfCourseEnrolled(courseId, userId);
    } catch (e) {
      return _courseData = null;
      debugPrint("Error fetching course data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
