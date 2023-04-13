import 'package:doc_saver_app/screens/authentication_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}
