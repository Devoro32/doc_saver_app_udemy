import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/widgets/custom_home_app_bar.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
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
          appBar: const CustomHomeAppBar(),

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
          body: ScreenBackgroundWidget(
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          spreadRadius: 4,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_pdf_type.png',
                              width: 50,
                            ),
                            SizeBoxHelper.sizeBox_5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  'Subtitle',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  'Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'View',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
