import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_lens_hub/features/ToolsContent/datamodel/CoverLetterResponseDataModel.dart';
import 'package:talent_lens_hub/features/ToolsContent/datamodel/interviewQuestionResponseDataModel.dart';

import '../../../api/api_controller.dart';
import '../datamodel/SolveBanglaMathDataModel.dart';
import '../datamodel/toolsResponseDataModel.dart';

class ToolsResponseProvider extends ChangeNotifier {
  ApiController _apiService = ApiController();

  ToolsResponseDataModel? _toolsResponse;
  InterviewQuestionsResponseDataModel? _interviewQuestionsResponseDataModel;
  CoverLetterResponseDataModel? _coverLetterResponseDataModel;
  SolveBanglaMathDataModel? _solveBanglaMathDataModel;

  ToolsResponseDataModel? get toolsResponse => _toolsResponse;

  InterviewQuestionsResponseDataModel? get interviewQuestionDataModel =>
      _interviewQuestionsResponseDataModel;

  CoverLetterResponseDataModel? get coverLetterResponseDataModel =>
      _coverLetterResponseDataModel;

  SolveBanglaMathDataModel? get solveBanglaMathDataModel =>
      _solveBanglaMathDataModel;

  Future<void> fetchMathSolutionResponse(
    int userId,
    String problemText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getMathSolutionResponse(
        userId,
        problemText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchMathImageSolutionResponse(
    File questionImage,
    int userId,
    String questionText,
  ) async {
    print("inside fetchMathImageSolutionResponse");
    try {
      final response = await _apiService.getMathImageResponse(
        questionImage,
        userId,
        questionText,
      );
      _solveBanglaMathDataModel = SolveBanglaMathDataModel.fromJson(response);

      print("Response from fetchMathImageSolutionResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in fetchMathImageSolutionResponse: $error');
      throw Exception('$error');
    }
  }

  Future<void> fetchCareerCounselorResponse(
    int userId,
    String problemText,
    String skillText,
    String interstTopic,
    String experinceText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getCareerCounselorResponse(
        userId,
        problemText,
        skillText,
        interstTopic,
        experinceText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchLifeCoachResponse(
    int userId,
    String problemText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getLifeCoachResponse(
        userId,
        problemText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchMentalHealthResponse(
    int userId,
    String problemText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getMentalHealthResponse(
        userId,
        problemText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchRelationshipCoachResponse(
    int userId,
    String problemText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getRelationshipCoachResponse(
        userId,
        problemText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchPsychologyResponse(
    int userId,
    String problemText,
  ) async {
    // print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getPsychologyResponse(
        userId,
        problemText,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchPsychologyResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in fetchPsychologyResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchInterviewQuestionResponse(
    int userId,
    String jobTitle,
    String jobDescription,
    String noOfQuestions,
  ) async {
    print("inside fetchInterviewQuestionResponse");
    try {
      final response = await _apiService.getInterviewQuestionResponse(
        userId,
        jobTitle,
        jobDescription,
        noOfQuestions,
      );
      _interviewQuestionsResponseDataModel =
          InterviewQuestionsResponseDataModel.fromJson(response);
      print("Response from getInterviewQuestionResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getInterviewQuestionResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }

  Future<void> fetchCoverLetterResponse(
    int userId,
    String jobTitle,
    String personalSkillText,
  ) async {
    print("inside fetchCoverLetterResponse");
    try {
      final response = await _apiService.getCoverLetterResponse(
        userId,
        jobTitle,
        personalSkillText,
      );
      _coverLetterResponseDataModel =
          CoverLetterResponseDataModel.fromJson(response);
      print("Response from getCoverLetterResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getCoverLetterResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }
}
