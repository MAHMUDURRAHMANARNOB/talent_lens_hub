import 'package:flutter/material.dart';
import '../../../../api/api_controller.dart';
import '../DataModel/CourseExamDataModel.dart';

class CourseExamProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  CourseExamModel? _currentQuestion;
  bool _isLoading = false;
  bool isExamCompleted = false;

  // Data to hold exam results
  double? finalScore;
  bool certificateEligible = false;
  String completionMessage = "";

  String? _errorMessage;

  CourseExamModel? get currentQuestion => _currentQuestion;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchQuestion({
    required String userId,
    required String courseId,
    String? examPaperId,
    String? questionId,
    String? ansId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiController.startCourseExam(
        userId: userId,
        courseId: courseId,
        examPaperId: examPaperId,
        questionId: questionId,
        ansId: ansId,
      );
      if (response['errorcode'] == 300) {
        // Exam completed case
        isExamCompleted = true;
        finalScore = double.tryParse(response['score'].toString()) ?? 0.0;
        certificateEligible = response['certificateeligible'] == 'Y';

        // Generate completion message
        completionMessage = finalScore! > 50
            ? "Congratulations! You passed the exam and are eligible for a certificate."
            : "You completed the exam, but your score is below 50. Better luck next time!";

        _currentQuestion = null;
        _errorMessage = null;
      } else {
        // Handle regular question response
        _currentQuestion = CourseExamModel.fromJson(response);
        _errorMessage = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    _currentQuestion = null;
    isExamCompleted = false;
    finalScore = null;
    completionMessage = '';
    certificateEligible = false;
    notifyListeners();
  }
}
