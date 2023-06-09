import 'dart:io';

import 'package:doc_saver_app/helper/snack_bar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class DocumentProvider extends ChangeNotifier {
  //firebase instance
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  File? _file;
  //get the file name
  String _selectedFileName = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String get selectedFileName => _selectedFileName;
  setSeletedFileName(String value) {
    _selectedFileName = value;
    notifyListeners();
  }

  pickDocument(BuildContext context) async {
    await FilePicker.platform
        .pickFiles(
      //determine the file type that is allowed
      allowMultiple: false,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      type: FileType.custom,
    )
        .then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        //get the file name
        setSeletedFileName(selectedFile.name);
        //141
        _file = File(selectedFile.path!);

        print('File name: ${selectedFile.name}');
      } else {
        SnackBarHelper.showErrorSnackbar(context, 'No file selected.');
      }
    });
  }

  bool _isFileUploading = false;
  bool get isFileUploading => _isFileUploading;
  setIsFileUploading(bool value) {
    _isFileUploading = value;
    notifyListeners();
  }

  resetAll() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    _selectedFileName = '';
    _file = null;
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;

//adding the information to firebase realtime storage database
  sendDocument({
    required BuildContext context,
  }) async {
    try {
      setIsFileUploading(true);
      UploadTask uploadTask = _firebaseStorage
          .ref()
          .child('files/$userId')
          .child(_selectedFileName)
          .putFile(_file!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      //files_info is the file directory for the realtime database where the below data is stored

      //147- add the user Id so we can filter the result out by the user
      await _firebaseDatabase.ref().child('files_info/$userId').push().set({
        'title': titleController.text,
        'note': noteController.text,
        'fileUrl': uploadedFileUrl,
        'dateAdded': DateTime.now().toString(),
        'fileName': _selectedFileName,
        //split the file name  by '.' and taking the last section
        'fileType': _selectedFileName.split('.').last,
      });
      resetAll();
      setIsFileUploading(false);
    } on FirebaseException catch (firebaseError) {
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
      setIsFileUploading(false);
    } catch (error) {
      SnackBarHelper.showErrorSnackbar(context, error.toString());
      setIsFileUploading(false);
    }
  }

  Future<void> deleteDocument(
      BuildContext context, String id, String fileName) async {
    //firebase storage database
    try {
      await _firebaseStorage.ref().child('files/$userId/$fileName').delete();
      print(' files deleted ${userId}/${fileName}');

      //firebase realtime database
      await _firebaseDatabase
          .ref()
          .child('files_info/$userId/$id')
          .remove()
          .then((value) {
        SnackBarHelper.showSuccessSnackbar(
            context, '$fileName successfully deleted');
      });
    } on FirebaseException catch (firebaseError) {
      SnackBarHelper.showErrorSnackbar(context, firebaseError.message!);
    } catch (error) {
      SnackBarHelper.showErrorSnackbar(context, error.toString());
    }
  }
}
