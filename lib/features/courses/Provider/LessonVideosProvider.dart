import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonVideosDataModel.dart';

import '../../../api/api_controller.dart';

class LessonVideosProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  List<LessonVideosDataModel> _lessonVideosDataModel = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<LessonVideosDataModel> get lessonVideosDataModel =>
      _lessonVideosDataModel;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchVideos(int lessonId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedVideos = await _apiController.fetchLessonVideos(lessonId);
      if (fetchedVideos.isEmpty) {
        _errorMessage = "No data available for this lesson.";
      } else {
        // Process the first item if the data is not empty
        _lessonVideosDataModel = fetchedVideos;
      }
      // _videos = fetchedVideos;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
