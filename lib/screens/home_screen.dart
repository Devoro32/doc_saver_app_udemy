import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/widgets/custom_home_app_bar.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/HomeScreen';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //safe area will cut the space for the top and the bottom for the navigator bar
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(),

        // appBar: AppBar(
        //   title: const Text('Home Page'),
        //   actions: [
        //     Consumer<AuthProvider>(builder: (context, provider, child) {
        //       return provider.isLoadingLogout
        //           ? const CircularProgressIndicator()
        //           : IconButton(
        //               onPressed: () {
        //                 provider.logOut(context);
        //               },
        //               icon: const Icon(Icons.logout),
        //             );
        //     })
        //   ],
        // ),
        body: const Scaffold(),
      ),
    );
  }
}
