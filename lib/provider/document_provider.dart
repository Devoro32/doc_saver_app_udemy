import 'package:doc_saver_app/helper/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class DocumentProvider extends ChangeNotifier {
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
      } else {
        SnackBarHelper.showErrorSnackbar(context, 'No file selected.');
      }
    });
  }
}
