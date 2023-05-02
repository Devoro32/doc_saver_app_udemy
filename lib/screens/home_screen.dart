import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/add_document_screen.dart';
import 'package:doc_saver_app/widgets/custom_floating_action_button.dart';
import 'package:doc_saver_app/widgets/custom_home_app_bar.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/file_card.dart';
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
          floatingActionButton: CustomFloatingActionButton(
            title: 'Add File',
            iconData: Icons.add,
            onTap: () {
              Navigator.pushNamed(context, AddDocumentScreen.routeName);
            },
          ),
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
                FileCard(
                    fileCardModel: FileCardModel(
                  title: 'This is the title',
                  subTitle: 'This is the subtitle',
                  dateAdded: '2023-04-29',
                  fileType: 'pdf',
                ))
              ],
            ),
          )),
    );
  }
}
