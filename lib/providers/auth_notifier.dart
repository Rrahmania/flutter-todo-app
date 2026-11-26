import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth/auth_service.dart';


class AuthNotifier with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Registrasi
  Future<bool> signUp(
      String email,
      String password,
      ) async {
    _setLoading(true);

    try {
      User? user = await _authService.signUp(
        email,
        password,
      );

      return user != null;
    } finally {
      _setLoading(false);
    }
  }

  // Login
  Future<bool> signIn(
      String email,
      String password,
      ) async {
    _setLoading(true);

    try {
      User? user = await _authService.signIn(
        email,
        password,
      );

      return user != null;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> signOut() async {
    await _authService.signOut();
  }
}