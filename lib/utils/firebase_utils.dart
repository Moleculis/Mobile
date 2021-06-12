import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  // Maximum count of documents for batch writing
  static const int maxBatchDocumentsCount = 500;

  static Future<void> batchUpdate(List<DocumentReference> documents, {
    required Map<String, dynamic> data,
    List<Map<String, dynamic>>? dataList,
  }) async {
    await _batchOperation(
      documents,
      _BatchOperationType.update,
      data: data,
      dataList: dataList,
    );
  }

  static Future<void> batchSet(List<DocumentReference> documents, {
    Map<String, dynamic>? data,
    List<Map<String, dynamic>>? dataList,
  }) async {
    await _batchOperation(
      documents,
      _BatchOperationType.set,
      data: data,
      dataList: dataList,
    );
  }

  static Future<void> batchDelete(List<DocumentReference> documents,) async {
    await _batchOperation(
      documents,
      _BatchOperationType.delete,
    );
  }

  static Future<void> _batchOperation(List<DocumentReference> documents,
      _BatchOperationType type, {
        Map<String, dynamic>? data,
        List<Map<String, dynamic>>? dataList,
      }) async {
    if (dataList != null) {
      assert(documents.length == dataList.length);
    } else if (type != _BatchOperationType.delete) {
      assert(
      data != null,
      'You have to provide either data or dataList for '
          'the operations other than delete',
      );
    }
    final List<WriteBatch> allBatches = [];
    WriteBatch tempBatch = FirebaseFirestore.instance.batch();
    int i = 0;
    int tempBatchDocumentsLength = 0;

    while (i < documents.length) {
      final document = documents[i];
      if (i % maxBatchDocumentsCount == 0 && i != 0) {
        allBatches.add(tempBatch);
        tempBatch = FirebaseFirestore.instance.batch();
        tempBatchDocumentsLength = 0;
      }
      late Map<String, dynamic> docData;
      if (type != _BatchOperationType.delete) {
        docData = data ?? dataList![i];
      }

      switch (type) {
        case _BatchOperationType.update:
          tempBatch.update(document, docData);
          break;
        case _BatchOperationType.set:
          tempBatch.set(document, docData);
          break;
        case _BatchOperationType.delete:
          tempBatch.delete(document);
          break;
      }
      i++;
      tempBatchDocumentsLength++;
    }

    if (tempBatchDocumentsLength <= maxBatchDocumentsCount) {
      allBatches.add(tempBatch);
    }

    for (final batch in allBatches) {
      await batch.commit().catchError((e, s) => throw e);
    }
  }
}

enum _BatchOperationType { update, set, delete }
