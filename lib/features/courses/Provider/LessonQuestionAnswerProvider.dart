import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonQuestionAnswerDataModel.dart';

import '../../../api/api_controller.dart';

class LessonQuestionAnswerProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  LessonQuestionAnswerDataModel? _responseData;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  LessonQuestionAnswerDataModel? get responseData => _responseData;

  final ApiController _apiController = ApiController();

  // Fetch lesson question and answer
  Future<void> fetchLessonQuestionAnswer({
    required String question,
    required String lessonAnswerId,
    required int userId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiController.fetchLessonQuestionAnswer(
        question: question,
        lessonAnswerId: lessonAnswerId,
        userId: userId,
      );
      // print("Provider response: $response");
      _responseData = LessonQuestionAnswerDataModel.fromJson(response);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
