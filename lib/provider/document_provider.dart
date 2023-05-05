import 'package:doc_saver_app/helper/snack_bar_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class DocumentProvider extends ChangeNotifier {
  //firebase instance
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  //get the file name
  String _selectedFileName = '';
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
        print('${selectedFile.name}');
        print('File name: ${selectedFile.name}');
        print('File bytes: ${selectedFile.bytes}');
        print('File size: ${selectedFile.size}');
      } else {
        SnackBarHelper.showErrorSnackbar(context, 'No file selected.');
      }
    });
  }

  sendDocument({required String title, required String note}) async {
    await _firebaseDatabase.ref().child('files_info').push().set({
      'title': title,
      'note': note,
      'fileURL': '',
      'dateAdded': DateTime.now().toString(),
      'fileName': _selectedFileName,
      //split the file name  by '.' and taking the last section
      'fileType': _selectedFileName.split('.').last,
    });
  }
}
