import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/widgets/custom_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = '/forgetPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
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
          CustomTextField(
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
          SizeBoxHelper.sizeBox20,
          CustomButton(
            onPressed: () {},
            title: 'forget Password',
          )
        ]),
      ),
    );
  }
}
