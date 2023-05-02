import 'dart:ffi';

import 'package:doc_saver_app/helper/size_box_helper.dart';
import 'package:doc_saver_app/provider/document_provider.dart';
import 'package:doc_saver_app/widgets/custom_floating_action_button.dart';
import 'package:doc_saver_app/widgets/custom_text_field.dart';
import 'package:doc_saver_app/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDocumentScreen extends StatefulWidget {
  static String routeName = '/addDocumentScreen';
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document'),
        centerTitle: true,
      ),
      floatingActionButton: CustomFloatingActionButton(
        title: 'Upload',
        iconData: Icons.check,
        onTap: () {},
      ),
      body: ScreenBackgroundWidget(
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextField(
                controller: titleController,
                hintText: 'Title',
                prefixIconData: Icons.title,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                labelText: 'Please enter the title',
              ),
              SizeBoxHelper.sizeBox20,
              CustomTextField(
                controller: noteController,
                hintText: 'Note',
                prefixIconData: Icons.note,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter note';
                  }
                  return null;
                },
                labelText: 'Please ent the note',
              ),
              SizeBoxHelper.sizeBox20,
              Consumer<DocumentProvider>(builder: (
                context,
                provider,
                child,
              ) {
                return InkWell(
                  onTap: () {
                    provider.pickDocument();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('filename'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add, size: 30, color: Colors.grey),
                            Text(
                              'Upload File',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
