/*
import 'package:flutter/material.dart';

import '../../../api/api_controller.dart';
import '../DataModel/CourseContentDataModel.dart';

class CourseContentProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<CourseDataModel> _courses = [];
  List<LessonDataModel> _chapters = []; // To store chapters
  List<LessonDataModel> _lessons = [];
  Map<int, List<LessonDataModel>> _chapterLessonsMap =
      {}; // Map to group lessons by chapterIndex

  // List<LessonDataModel> _regularLessons = []; // To store regular lessons

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<CourseDataModel> get courses => _courses;

  List<LessonDataModel> get lessons => _lessons;

  List<LessonDataModel> get chapters => _chapters;

  // List<LessonDataModel> get regularLessons => _regularLessons;

  Map<int, List<LessonDataModel>> get chapterLessonsMap => _chapterLessonsMap;

  final ApiController _apiController = ApiController();

  Future<void> fetchCourseContent(int? courseCategoryId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call the API using your provided method.
      final response = await _apiController.getCoursesContent(courseCategoryId);

      // Debugging: Print response structure
      // print('API Response: $response');

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
        // Separate chapters and regular lessons based on "isChapter"
        */
/*_chapters =
            _lessons.where((lesson) => lesson.isChapter == 'Y').toList();
        _regularLessons =
            _lessons.where((lesson) => lesson.isChapter == 'N').toList();*/ /*

        _chapterLessonsMap = {};
        for (var lesson in _lessons) {
          if (lesson.isChapter == 'Y') {
            // Create a new entry for a chapter
            _chapterLessonsMap[lesson.chapterIndex] = [];
          }
        }
        for (var lesson in _lessons) {
          if (lesson.isChapter == 'N') {
            // Add regular lessons to their corresponding chapterIndex
            _chapterLessonsMap[lesson.chapterIndex]?.add(lesson);
          }
        }
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
*/
import 'package:flutter/material.dart';

import '../../../api/api_controller.dart';
import '../DataModel/CourseContentDataModel.dart';

class CourseContentProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<CourseDataModel> _courses = [];
  List<LessonDataModel> _lessons = [];
  Map<int, List<LessonDataModel>> _chapterLessonsMap = {};

  final ApiController _apiController = ApiController();

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<CourseDataModel> get courses => _courses;

  List<LessonDataModel> get lessons => _lessons;

  Map<int, List<LessonDataModel>> get chapterLessonsMap => _chapterLessonsMap;

  Future<void> fetchCourseContent(int? courseCategoryId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiController.getCoursesContent(courseCategoryId);

      if (response['coursedata'] is List) {
        _courses = (response['coursedata'] as List)
            .map((item) => CourseDataModel.fromJson(item))
            .toList();
      }

      if (response['lessondata'] is List) {
        _lessons = (response['lessondata'] as List)
            .map((item) => LessonDataModel.fromJson(item))
            .toList();
        notifyListeners();

        /*_chapterLessonsMap = {};
        for (var lesson in _lessons) {
          if (lesson.isChapter == 'Y') {
            _chapterLessonsMap[lesson.chapterIndex] = [];
          } else if (lesson.isChapter == 'N') {
            _chapterLessonsMap[lesson.chapterIndex]?.add(lesson);
            // _lessons.add(lesson);
          }
        }*/
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch courses: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
