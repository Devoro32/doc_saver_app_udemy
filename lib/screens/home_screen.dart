import 'dart:async';

import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/screens/add_document_screen.dart';
import 'package:doc_saver_app/widgets/custom_floating_action_button.dart';
import 'package:doc_saver_app/widgets/custom_home_app_bar.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/file_card.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/HomeScreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  StreamController<DatabaseEvent> streamController = StreamController();
//searching through the database

//getting the userid 147
  String userId = FirebaseAuth.instance.currentUser!.uid;
  setStream() {
    FirebaseDatabase.instance
        .ref()
        //search in the title field for matching words
        .child('files_info/$userId')
        .orderByChild('title')
        .startAt(searchController.text)
        .endAt('${searchController.text}' '\uf8ff')
        .onValue
        .listen((event) {
      //updating the UI without using the setState ()
      //created the stream controller so we can use the .add()
      //this allow for realtime adding of the event to the database
      print('stream event: ${event}');
      streamController.add(event);
    });
  }

//this will be called before the build method of the screen
  @override
  void initState() {
    setStream();
    super.initState();
  }

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
          appBar: CustomHomeAppBar(
            controller: searchController,
            onSearch: () {
              setStream();
            },
          ),
          body: ScreenBackgroundWidget(
            child: StreamBuilder<DatabaseEvent>(
                stream: streamController.stream,
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
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_no_file.png',
                          width: 140,
                          height: 150,
                        ),
                        Text('No data'),
                      ],
                    );
                  }
                }),
          )),
    );
  }
}
