import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {
  // Simulate user authentication
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Simple validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, accept any valid email/password
      return UserModel(
        id: 'local_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@')[0],
        role: 'user',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Sign in error: $e');
      return null;
    }
  }

  Future<UserModel?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Simple validation
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        throw Exception('All fields are required');
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      return UserModel(
        id: 'local_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        role: 'user',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Sign up error: $e');
      return null;
    }
  }

  Future<UserModel?> adminSignIn(String email, String password) async {
    try {
      // Simple validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, accept any valid email/password
      return UserModel(
        id: 'admin_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: 'Admin',
        role: 'admin',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
    } catch (e) {
      debugPrint('Admin sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
  }
} 