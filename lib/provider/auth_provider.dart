import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
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
}
