import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_lens_hub/api/api_controller.dart';

import '../models/CreateUserResponse.dart';
import '../models/login_response.dart';
import '../models/user.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

// providers/auth_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  ApiController apiController = ApiController();
  AppUser? _user;

  bool _isLoading = false;
  SignUpResponse? _signupResponse;

  bool get isLoading => _isLoading;

  SignUpResponse? get signupResponse => _signupResponse;

  AppUser? get user => _user;

  Future<void> login(String username, String password) async {
    try {
      // Call the loginApi method from the ApiService
      LoginResponse loginResponse =
          await ApiController.loginApi(username, password);

      // Process the API response

      _user = AppUser(
        id: loginResponse.id!,
        username: loginResponse.username,
        name: loginResponse.name,
        email: loginResponse.email,
        mobile: loginResponse.phone,
        photo: loginResponse.photo,
        userType: loginResponse.userType,
      );

      // Notify listeners to trigger a rebuild in the UI
      notifyListeners();
    } catch (error) {
      // Handle errors from the ApiService
      print("Error during login: $error");
    }
  }

  Future<void> signUpUser({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? userType,
  }) async {
    _setLoading(true);
    try {
      final apiResponse = await apiController.createUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        userType: userType,
      );

      _signupResponse = apiResponse;
      print(_signupResponse);
    } catch (e) {
      _signupResponse = SignUpResponse(
        success: false,
        message: "An error occurred: ${e.toString()}",
      );
    } finally {
      _setLoading(false);
    }
  }

  /// Private method to set loading state and notify listeners
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      // Clear stored credentials using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');

      // Clear any other session data or tokens

      // Notify listeners that the user has logged out
      _user = null;
      notifyListeners();
    } catch (error) {
      // Handle errors gracefully
      print('Error during logout: $error');
      // You might want to display a message to the user or perform other error handling here
    }
  }
}
