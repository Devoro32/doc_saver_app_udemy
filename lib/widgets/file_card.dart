// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/models/file_card_model.dart';

class FileCard extends StatelessWidget {
  final FileCardModel fileCardModel;
  const FileCard({
    Key? key,
    required this.fileCardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      fileCardModel.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      fileCardModel.subTitle,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      fileCardModel.dateAdded,
                      style: Theme.of(context).textTheme.caption!.copyWith(
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
    );
  }
}