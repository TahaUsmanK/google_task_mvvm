import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthModel _authModel = AuthModel();

  User? _user;
  User? get user => _user;

  AuthViewModel() {}

  Future<void> signInWithGoogle() async {
    _user = await _authModel.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authModel.signOut();
    _user = null;
    notifyListeners();
  }
}
