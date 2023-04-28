import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = '/forgetPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundWidget(
        child: ListView(children: [
          SizeBoxHelper.sizeBox100,
          Image.asset(
            'assets/images/icon_image.png',
            height: 150,
          ),
          SizeBoxHelper.sizeBox20,
          const Text(
            'Enter your email to reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizeBoxHelper.sizeBox20,
          Form(
            key: _key,
            child: CustomTextField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIconData: Icons.email,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                } else {
                  return null;
                }
              },
            ),
          ),
          SizeBoxHelper.sizeBox20,
          Consumer<AuthProvider>(builder: (context, provider, child) {
            return provider.isLoadingForgetPassword
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        //code for getpassword check
                        provider.forgetPassword(
                          context,
                          emailController.text,
                        );
                      }
                    },
                    title: 'Forget Password',
                  );
          })
        ]),
      ),
    );
  }
}
