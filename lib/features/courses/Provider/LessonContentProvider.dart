import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonContentDataModel.dart';
import '../../../api/api_controller.dart';

class LessonContentProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  LessonContentDataModel? _lessonContentDataModel;

  LessonContentDataModel? get lessonContentDataModel => _lessonContentDataModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> getLessonAnswer(int lessonId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _apiController.fetchLessonAnswer(lessonId);
      // print("hello bro ${data[0].toString()}");
      // _lessonContentDataModel = LessonContentDataModel.fromJson(data[0]);
      if (data.isEmpty) {
        _errorMessage = "No data available for this lesson.";
      } else {
        // Process the first item if the data is not empty
        _lessonContentDataModel = LessonContentDataModel.fromJson(data[0]);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
