import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:ragg/api/summary_service.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({
    super.key,
    required this.summary,
    required this.fileName,
    this.isHistory = false,
  });

  final String summary;
  final String fileName;
  final bool isHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MarkdownBody(
                data: summary,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(fontSize: 16),
                  strong: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              if(!isHistory) ...[
                const SizedBox(height:20),
                ElevatedButton(
                  onPressed: () async {
                    final summaryService = SummaryService();
                    summaryService.storeSummary(summary, fileName);
                },
                child: const Text('Save Summary'),
              ),]
            ],
          ),
        ),
      ),
    );
  }
}
