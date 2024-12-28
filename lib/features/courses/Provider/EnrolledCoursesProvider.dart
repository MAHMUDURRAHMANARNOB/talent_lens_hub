import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/EnrolledCoursesDataModel.dart';

import '../../../api/api_controller.dart';

class EnrolledCoursesProvider with ChangeNotifier {
  List<EnrolledCoursesDataModel> _enrolledCourses = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<EnrolledCoursesDataModel> get enrolledCourses => _enrolledCourses;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  // Method to fetch courses and notify listeners
  Future<void> getEnrolledCourses(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiController = ApiController();
      _enrolledCourses = await apiController.fetchEnrolledCourses(userId);
      _errorMessage = '';
      // print("hi: ${_enrolledCourses.length}");
    } catch (e) {
      _errorMessage = e.toString();
      _enrolledCourses = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
