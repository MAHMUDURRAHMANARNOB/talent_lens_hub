import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/RecommandedCoursesForUser/recommendedCoursesDataModel.dart';

import '../../../api/api_controller.dart';

class RecommendedCourseByIdProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  RecommendedCoursesDataModel? _recommendedCourseById;
  bool _isLoading = false;
  String? _errorMessage;

  RecommendedCoursesDataModel? get recommendedCourseById =>
      _recommendedCourseById;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<RecommendedCoursesDataModel?> fetchRecommendedCourses(
      String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiController.recommendCoursesForUser(userId);
      print(response);
      _recommendedCourseById = response; // Already parsed data
      return _recommendedCourseById;
    } catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
      _recommendedCourseById = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
