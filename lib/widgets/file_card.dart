// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:doc_saver_app/provider/document_provider.dart';
import 'package:doc_saver_app/screens/document_view_screen.dart';
import 'package:flutter/material.dart';

import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/models/file_card_model.dart';
import 'package:provider/provider.dart';

class FileCard extends StatelessWidget {
  final FileCardModel fileCardModel;
  const FileCard({
    Key? key,
    required this.fileCardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                fileCardModel.fileType == 'pdf'
                    ? Image.asset(
                        'assets/images/icon_pdf_type.png',
                        width: 50,
                      )
                    : Image.asset(
                        'assets/images/icon_image_type.png',
                        width: 50,
                      ),
                SizeBoxHelper.sizeBox_5,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileCardModel.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        fileCardModel.subTitle,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Date added: ${fileCardModel.dateAdded.substring(0, 10)}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            title: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              fileCardModel.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<DocumentProvider>(context,
                                          listen: false)
                                      .deleteDocument(
                                    context,
                                    fileCardModel.id,
                                    fileCardModel.fileName,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DocumentViewScreen.routeName,
                      arguments: DocumentViewScreenArgs(
                        fileName: fileCardModel.fileName,
                        fileUrl: fileCardModel.fileUrl,
                        fileType: fileCardModel.fileType,
                      ),
                    );
                  },
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
    );
  }
}
