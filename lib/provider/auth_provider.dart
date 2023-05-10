import 'package:doc_saver_app/helper/snack_bar_helper.dart';
import 'package:doc_saver_app/screens/authentication_screen.dart';
import 'package:doc_saver_app/screens/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  singUp(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      setIsLoading(true);
      UserCredential userCredntial = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        //151 setting the username
        await _firebaseDatabase
            .ref()
            .child('user_info/${value.user!.uid}')
            .set({'username': username});
        setIsLoading(false);

        SnackBarHelper.showSuccessSnackbar(context, 'Successfully register');
        Navigator.of(context).pushNamed(HomePage.routeName);
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
    } catch (e) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackbar(context, e.toString());
    }
  }

  signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        setIsLoading(false);
        SnackBarHelper.showSuccessSnackbar(context, 'Login success');
        Navigator.of(context).pushNamed(HomePage.routeName);
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
    } catch (e) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackbar(context, e.toString());
    }
  }

  bool _isLoadingForgetPassword = false;
  bool get isLoadingForgetPassword => _isLoadingForgetPassword;

  setIsLoadingForgetPassword(bool value) {
    _isLoadingForgetPassword = value;
    notifyListeners();
  }

  forgetPassword(BuildContext context, String email) async {
    try {
      setIsLoadingForgetPassword(true);
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        setIsLoadingForgetPassword(false);
        SnackBarHelper.showSuccessSnackbar(context, 'Email sent');
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoadingForgetPassword(false);
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
    } catch (e) {
      setIsLoadingForgetPassword(false);
      SnackBarHelper.showErrorSnackbar(context, e.toString());
    }
  }

  bool _isLoadingLogout = false;
  bool get isLoadingLogout => _isLoadingLogout;
  setIsLoadingLogout(bool value) {
    _isLoadingLogout = value;
    notifyListeners();
  }

  logOut(BuildContext context) async {
    try {
      setIsLoadingLogout(true);
      await _firebaseAuth.signOut().then((value) {
        setIsLoadingLogout(false);
        SnackBarHelper.showSuccessSnackbar(context, 'Successfully logged out');
        Navigator.of(context).pushNamed(AuthenticationScreen.routeName);
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoadingLogout(false);
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
    } catch (e) {
      setIsLoadingLogout(false);
      SnackBarHelper.showErrorSnackbar(context, e.toString());
    }
  }
}
