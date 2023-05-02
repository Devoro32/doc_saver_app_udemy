import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';

class DocumentProvider extends ChangeNotifier {
  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
  }
}
