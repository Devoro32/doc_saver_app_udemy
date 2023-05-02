import 'package:doc_saver_app/helper/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class DocumentProvider extends ChangeNotifier {
  pickDocument(BuildContext context) async {
    await FilePicker.platform
        .pickFiles(
      allowMultiple: false,
      allowedExtensions: [
        'pdf',
        'png',
        'jpg',
        'jpeg',
      ],
      type: FileType.custom,
    )
        .then((result) {
      if (result != null) {
        PlatformFile selectedFile = result.files.first;
      } else {
        SnackBarHelper.showErrorSnackbar(context, 'No file selected.');
      }
    });
  }
}
