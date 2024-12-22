import 'package:flutter/material.dart';

import '../../../api/api_controller.dart';
import '../DataModel/CourseContentDataModel.dart';

class CourseContentProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<CourseDataModel> _courses = [];
  List<LessonDataModel> _lessons = [];

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<CourseDataModel> get courses => _courses;

  List<LessonDataModel> get lessons => _lessons;

  final ApiController _apiController =
      ApiController(); // Ensure this is the class containing the API method.

  Future<void> fetchCourseContent(int? courseCategoryId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call the API using your provided method.
      final response = await _apiController.getCoursesContent(courseCategoryId);

      // Debugging: Print response structure
      print('API Response: $response');

      // Check and parse coursedata
      if (response['coursedata'] is List) {
        final courseData = (response['coursedata'] as List)
            .map((item) => CourseDataModel.fromJson(item))
            .toList();
        _courses = courseData;
      } else {
        throw Exception('Expected coursedata to be a list');
      }

      // Check and parse lessondata
      if (response['lessondata'] is List) {
        final lessonData = (response['lessondata'] as List)
            .map((item) => LessonDataModel.fromJson(item))
            .toList();
        _lessons = lessonData;
      } else {
        throw Exception('Expected lessondata to be a list');
      }
    } catch (e) {
      // Capture and handle errors.
      _errorMessage = 'Failed to fetch courses: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
