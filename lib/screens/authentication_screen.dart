import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/forget_password_screen.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = '/authenticationScreen';
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController usernameController =
      TextEditingController(text: 'Edane Barton');
  TextEditingController emailController =
      TextEditingController(text: 'edanebarton@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456789');
  TextEditingController confirmpasswordController =
      TextEditingController(text: '123456789');
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: ScreenBackgroundWidget(
          child: Form(
            key: _key,
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/icon_image.png',
                  height: 150,
                ),
                SizeBoxHelper.sizeBox20,
                if (!provider.isLogin)
                  CustomTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a username';
                      } else {
                        return null;
                      }
                    },
                    controller: usernameController,
                    hintText: 'Enter your username',
                    labelText: 'Username',
                    prefixIconData: Icons.person,
                  ),
                SizeBoxHelper.sizeBox20,
                CustomTextField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  prefixIconData: Icons.email,
                ),
                SizeBoxHelper.sizeBox20,
                CustomTextField(
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Please enter a password, min 8 characters';
                    } else {
                      return null;
                    }
                  },
                  obsecureText: provider.obscureText,
                  controller: passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  prefixIconData: Icons.password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      provider.setObscureText();
                    },
                    icon: Icon(
                      provider.obscureText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                SizeBoxHelper.sizeBox20,
                if (!provider.isLogin)
                  CustomTextField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value';
                      } else if (value != passwordController.text) {
                        return 'Password does not match';
                      } else {
                        return null;
                      }
                    },
                    obsecureText: provider.obscureText,
                    controller: confirmpasswordController,
                    hintText: 'Reenter your password',
                    labelText: 'Password',
                    prefixIconData: Icons.password,
                    suffixIcon: IconButton(
                      onPressed: () {
                        provider.setObscureText();
                      },
                      icon: Icon(
                        provider.obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                SizeBoxHelper.sizeBox20,
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            if (provider.isLogin) {
                              provider.signIn(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              provider.singUp(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }
                        },
                        title: provider.isLogin ? ' Login' : 'Register',
                      ),
                SizeBoxHelper.sizeBox20,
                MaterialButton(
                  onPressed: () {
                    provider.setIsLogin();
                  },
                  child: Text(
                    provider.isLogin
                        ? 'Don\'t have an account?Register'
                        : 'Already have an account? Login',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ForgetPasswordScreen.routeName);
                  },
                  child: const Text('Forgot password'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
