import 'package:doc_saver_app/firebase_options.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/authentication_screen.dart';
import 'package:doc_saver_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/forget_password_screen.dart';

void main() async {
  //flutter widgets needs to be initilized before using them
  WidgetsFlutterBinding.ensureInitialized();
  //indicate the default system
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc Saver App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                )))),
        initialRoute: AuthenticationScreen.routeName,
        routes: {
          AuthenticationScreen.routeName: (context) =>
              const AuthenticationScreen(),
          ForgetPasswordScreen.routeName: (context) =>
              const ForgetPasswordScreen(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
