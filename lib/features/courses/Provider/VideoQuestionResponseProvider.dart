import 'package:flutter/material.dart';
import 'package:talent_lens_hub/api/api_controller.dart';
import 'package:talent_lens_hub/features/courses/DataModel/VideoQuestionResponseDataModel.dart';

class VideoQuestionResponseProvider with ChangeNotifier {
  ApiController _apiService = ApiController();
  bool _isLoading = false;
  String? _errorMessage;

  VideoQuestionResponseDataModel? _videoQuestionResponseDataModel;

  VideoQuestionResponseDataModel? get videoQuestionResponse =>
      _videoQuestionResponseDataModel;

  // CourseListResponse? get courseListResponse => _courseListResponse;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  // final CourseApiController _apiController = CourseApiController();

  Future<void> getVideoQuestionResponse(
    String question,
    int videoID,
    int userId,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print(
          "Response from getVideoQuestionResponse: ${question} $videoID, $userId");

      final response = await _apiService.fetchVideoAnswer(
        question: question,
        videoID: videoID,
        userId: userId,
      );
      _videoQuestionResponseDataModel =
          VideoQuestionResponseDataModel.fromJson(response);
      print("Response from getVideoQuestionResponse: ${response}");
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      print('Error in getVideoQuestionResponse: $_errorMessage');
      throw Exception('Failed to load data. Check your network connection.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
