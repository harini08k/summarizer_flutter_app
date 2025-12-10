import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.file});

  final PlatformFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Document Preview')),
      body: Center(child: _buildPreviewWidget(file)),
    );
  }

  Widget _buildPreviewWidget(PlatformFile file) {
    switch (file.extension) {
      case 'pdf':
        return PDFView(filePath: file.path!);
      case 'docx':
        return FutureBuilder<String>(
          future: _readDocxFile(file.path!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  snapshot.data!,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error reading file: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        );

      case 'txt':
        return FutureBuilder<String>(
          future: _readTextFiles(file.path!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  snapshot.data!,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error reading file: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        );
      default:
        return const Text('Unsupported file format');
    }
  }

  Future<String> _readDocxFile(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final text = docxToText(bytes);
      return text;
    } catch (e) {
      throw Exception('Error reading file: $e');
    }
  }

  Future<String> _readTextFiles(String filePath) async {
    try {
      final file = File(filePath);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      throw Exception('Error reading file: $e');
    }
  }
}
