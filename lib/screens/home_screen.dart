import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/add_document_screen.dart';
import 'package:doc_saver_app/widgets/custom_floating_action_button.dart';
import 'package:doc_saver_app/widgets/custom_home_app_bar.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/file_card.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:firebase_database/firebase_database.dart';
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
            child: StreamBuilder<DatabaseEvent>(
                stream:
                    FirebaseDatabase.instance.ref().child('files_info').onValue,
                builder: (context, snapshot) {
                  List<FileCardModel> _list = [];

                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    print('Snapshot: ${snapshot.data!}');
                    print('Snapshot data: ${snapshot.data!.snapshot.value}');
                    (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                        .forEach((key, value) {
                      print('Key:  ${key}');
                      print('Value: ${value}');
                      //using the factory in the document_provider to make the list builder easier
                      _list.add(FileCardModel.fromJson(value));
                    });
                    return ListView(
                      children: _list
                          .map(
                            (e) => FileCard(
                              fileCardModel: FileCardModel(
                                title: e.title,
                                subTitle: e.subTitle,
                                dateAdded: e.dateAdded,
                                fileUrl: e.fileUrl,
                                fileType: e.fileType,
                                fileName: e.fileName,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return const Text('No data');
                  }
                }),
          )),
    );
  }
}
