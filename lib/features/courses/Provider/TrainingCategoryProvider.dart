import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/courses/DataModel/TrainingCategoryDataModel.dart';
import '../../../api/api_controller.dart';

class TrainingCategoryProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();

  bool _isLoading = false;
  String? _errorMessage;
  List<TrainingCategoryDataModel> _categories = [];

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<TrainingCategoryDataModel> get categories => _categories;

  Future<void> fetchTrainingCategories() async {
    _isLoading = true;
    _errorMessage = null;
    // notifyListeners();

    try {
      // Fetch data from API
      final List<TrainingCategoryDataModel> response =
          await _apiController.getTrainingCategories();

      // Assign fetched data to _categories
      _categories = response;

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
      print('Error in fetchTrainingCategories: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
