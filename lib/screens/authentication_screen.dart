import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = '/authenticationScreen';
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();

class _AuthenticationScreenState extends State<AuthenticationScreen> {
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
            SizeBoxHelper.sizeBox20,
            CustomTextField(
              controller: usernameController,
              hintText: 'Enter your username',
              labelText: 'Username',
              prefixIconData: Icons.person,
            ),
            SizeBoxHelper.sizeBox20,
            CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
              labelText: 'Email',
              prefixIconData: Icons.email,
            ),
            SizeBoxHelper.sizeBox20,
            CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              labelText: 'Password',
              prefixIconData: Icons.password,
              suffixIcon: const Icon(Icons.remove_red_eye),
            ),
            SizeBoxHelper.sizeBox20,
            CustomTextField(
              controller: confirmpasswordController,
              hintText: 'Reenter your password',
              labelText: 'Password',
              prefixIconData: Icons.password,
              suffixIcon: const Icon(Icons.remove_red_eye),
            ),
            SizeBoxHelper.sizeBox20,
            CustomButton(onPressed: () {}, title: 'Register'),
            SizeBoxHelper.sizeBox20,
            MaterialButton(
              onPressed: () {},
              child: const Text('Already have an account? Login'),
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text('Forgot password'),
            ),
          ],
        ),
      ),
    );
  }
}
