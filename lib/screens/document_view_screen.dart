import 'package:flutter/material.dart';

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
      body: Image.network(args.fileUrl),
    );
  }
}

class DocumentViewScreenArgs {
  final String fileUrl;
  final String fileName;
  DocumentViewScreenArgs({
    required this.fileName,
    required this.fileUrl,
  });
}
