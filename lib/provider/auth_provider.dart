import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _islogin = true;
  bool get isLogin => _islogin;

  setIsLogin() {
    _islogin = !_islogin;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  singUp({
    required String email,
    required String password,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signIn({
    required String email,
    required String password,
  }) {
    _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
