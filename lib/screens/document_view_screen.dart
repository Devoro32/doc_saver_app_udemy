import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class DocumentViewScreen extends StatelessWidget {
  static String routeName = '/documentViewScreen';
  const DocumentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DocumentViewScreenArgs;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.fileName),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return args.fileType == 'pdf'
                  //we need to know the path where the file is stored in the phone
                  //to open it we will download it from firebase and open on the phone
                  ? PdfView(path: snapshot.data!)
                  //coming from the network rather than local storage
                  //: Image.network(args.fileUrl);
                  : Image.file(File(snapshot.data!));
            } else {
              return const CircularProgressIndicator();
            }
          },
          future: getDocumentData(args),
        ));
  }
}

Future<String> getDocumentData(
    DocumentViewScreenArgs documentviewScreenArgs) async {
  /*
  final response = await get(Uri.parse(documentviewScreenArgs.fileUrl));
//get the path where the file is downloaded
  print('Response: ${response.bodyBytes}');
  final directory = await getApplicationSupportDirectory();
  //149
  print('Directory: {directory.path}');
  //indicating where to place the file
  File file = File('${directory.path}/${documentviewScreenArgs.fileName}');
  print('file path: ${file.path}');
  
  

  //write the file to the desire location
  await file.writeAsBytes(response.bodyBytes);
  return file.path;
*/
  //!check if the file exists-CACHE system
  final directory = await getApplicationSupportDirectory();
  File file = File('${directory.path}/${documentviewScreenArgs.fileName}');

  if (await file.exists()) {
    print('file exist!');
    return file.path;
  } else {
    print('file downloaded!');
    final response = await get(Uri.parse(documentviewScreenArgs.fileUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }
}

class DocumentViewScreenArgs {
  final String fileUrl;
  final String fileName;
  final String fileType;
  DocumentViewScreenArgs({
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
  });
}
