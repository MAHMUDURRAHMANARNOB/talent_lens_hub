import 'package:flutter/material.dart';

import '../../../api/api_controller.dart';
import '../datamodels/subscriptionPlansDataModel.dart';

class SubscriptionProvider extends ChangeNotifier {
  final ApiController _apiController = ApiController();
  List<SubscriptionPlan> _subscriptions = [];
  bool _isLoading = false;

  List<SubscriptionPlan> get subscriptions => _subscriptions;

  bool get isLoading => _isLoading;

  Future<List<SubscriptionPlan>> fetchSubscriptions() async {
    try {
      return await _apiController.getSubscriptions();
    } catch (e) {
      debugPrint('Error fetching subscriptions: $e');
      return [];
    }
  }
}
