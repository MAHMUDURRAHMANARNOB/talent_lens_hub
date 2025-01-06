import 'package:flutter/material.dart';
import 'package:talent_lens_hub/api/api_controller.dart';

import '../models/UserStatsDataModel.dart';

class UserStatesProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  UserStatsDataModel? _userStats;
  bool _isLoading = false;
  String? _errorMessage;

  UserStatsDataModel? get userStats => _userStats;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  /// Fetch dashboard activity data for a specific user
  Future<void> getUserStates(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiController.fetchUserStates(userId);
      _userStats = UserStatsDataModel.fromJson(response);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
