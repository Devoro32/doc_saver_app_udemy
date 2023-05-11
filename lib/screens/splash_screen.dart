import 'package:doc_saver_app/screens/authentication_screen.dart';
import 'package:doc_saver_app/screens/home_screen.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ).then((value) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context)
            .pushReplacementNamed(AuthenticationScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundWidget(
        child: Center(
          child: Image.asset('assets/images/icon_image.png'),
        ),
      ),
    );
  }
}
