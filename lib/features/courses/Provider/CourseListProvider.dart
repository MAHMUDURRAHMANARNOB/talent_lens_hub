import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CourseListDataModel.dart';

import '../../../api/api_controller.dart';

class CourseListProvider extends ChangeNotifier {
  List<CourseListDataModel> _courses = [];
  bool _isLoading = false;

  List<CourseListDataModel> get courses => _courses;

  bool get isLoading => _isLoading;
  ApiController apiController = ApiController();

  Future<void> fetchCoursesById(int courseCategoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _courses = await apiController.getCoursesByCategory(courseCategoryId);
    } catch (e) {
      print('Error fetching courses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
