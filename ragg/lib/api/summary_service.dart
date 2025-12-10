import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ragg/api/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SummaryService {
  final ApiClient _apiClient = ApiClient();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> summarizeDocument(
    PlatformFile file,
    double summaryLength,
    int detailLevel,
  ) async {
    final summary = await _apiClient.summarizeDocument(
      file.path!,
      summaryLength,
      detailLevel,
    );
    return summary;
  }

  void storeSummary(String summary, String fileName) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('summaries')
        .add({
        'filename': fileName,
          'summary': summary,
          
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSummaries() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('summaries')
        .snapshots();
  }

  void deleteSummary(String docId){
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('summaries')
        .doc(docId)
        .delete();
  }
}
