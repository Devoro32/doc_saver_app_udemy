import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  static String routeName = '/authenticationScreen';
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/icon_image.png',
              height: 150,
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Enter your email',
              labelText: 'Email',
              prefixIconData: Icons.email,
            ),
          ],
        ),
      ),
    );
  }
}
