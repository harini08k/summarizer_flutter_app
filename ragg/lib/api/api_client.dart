import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl = 'http://10.0.2.2:5000';

  Future<String> summarizeDocument(
    String filePath,
    double summaryLength,
    int detailLevel,
  ) async {
    final url = Uri.parse('$_baseUrl/api/summarize');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('document', filePath));
    request.fields['summaryLength'] = summaryLength.toString();
    request.fields['detailLevel'] = detailLevel.toString();

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return jsonDecode(responseData)['summary'];
    } else {
      throw Exception('Failed to summarize document');
    }
  }
}
